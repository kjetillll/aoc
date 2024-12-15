#Animate run:  perl 2024_day_15_part_2.pl 2024_day_15_input.txt | perl -MTime::HiRes=usleep -pe'/move/&&usleep(5e4)'

use strict; use warnings; use v5.10; use List::Util qw(all sum);

my($map,$moves) = split/\n\n/, join '', <>;
my @move = $moves =~ /./g;
$map =~ s/./{ '#'=>'##', 'O'=>'[]', '.'=>'..', '@'=>'@.' }->{$&}/ge; #part 2 map change
my($x,$y,$w,$n,$wx,$wy,%grid)=(0,0); for($map=~/.+/g){$grid{$x++,$y}=$_ for/./g;$w//=$x;$y++;$x=0}
($x,$y) = $map=~/@/ ? (length($`)%($w+1),int(length($`)/($w+1))) : die;
say "x: $x   y: $y   w: $w   moves: ".@move."   init map:"; say $map;

for my $move (@move){
    my($dx,$dy) = @{{'>',[1,0],'<',[-1,0],'v',[0,1],'^',[0,-1]}->{$move}};
    say "--------------- move ".++$n." of ".@move."   x: $x   y: $y   move: $move";
    my $pm = $move=~/<|>/ ? sub{ my $p = $move eq '<' ?']' : '[';
				 [$grid{$wx,    $wy  } eq $p  => $wx+$dx, $wy  ],
				 [$grid{$wx+$dx,$wy  } eq $p  => $wx+$dx, $wy  ] }
                          : sub{ [$grid{$wx,  $wy+$dy} eq '[' => $wx,   $wy+$dy],
				 [$grid{$wx,  $wy+$dy} eq '[' => $wx+1, $wy+$dy],
				 [$grid{$wx,  $wy+$dy} eq ']' => $wx,   $wy+$dy],
				 [$grid{$wx,  $wy+$dy} eq ']' => $wx-1, $wy+$dy] };
    my @gridmoves;
    my @work = ( [$x,$y] );
    while(@work){
        push @gridmoves, [ ($wx,$wy) = @{shift@work} ];
        push @work, grep shift@$_, &$pm; #pm=potential moves
    }
    if( all{ my($x,$y)=@$_; $grid{$x+$dx,$y+$dy} ne '#' } @gridmoves ){
        push @$_, $grid{join$;,@$_} for @gridmoves;
        for(reverse @gridmoves){
            my($mx,$my,$mc) = @$_;
            my $pos     = $mx       + $my       * ($w+1);
            my $pos_new = ($mx+$dx) + ($my+$dy) * ($w+1);
            substr($map,$pos_new,1) = $grid{$mx+$dx, $my+$dy} = $mc;
            substr($map,$pos,    1) = $grid{$mx,     $my    } = '.';
        }
        $x += $dx, $y += $dy if @gridmoves
    }
    say $map;
}
say "Answer: " . sum map{my($x,$y)=/\d+/g;$x+$y*100}grep$grid{$_}eq'[',keys%grid;

__END__

Run:
time perl 2024_day_15_part_2.pl 2024_day_15_input.txt | tail      # 0.28 sec

####.......[].[][]..[].[].........................[][]##.[].................[]..[]##[][]........[]##
####........[]..[][]##[][]..##......##[]..[].[][]...####....##..........[]......[]..##[]..........##
##..[]..........[]##................[]..[].[][][][].....................##[][]..[]..[][]..[][]....##
##[]..............[]##........[]...............[].[]..........[]..[]......[]....[]..##[]..[]....[]##
##...............[].......[].......[].........[][][].......[].[]............[]........[][]........##
##[].......................[]................[][].[]........[]..##....[]....[]......[]....[][]....##
##[]...[]....[].......##.[].[]..[][].[].....[][]...[]....[].##[][]....[]......[]....[]..[]........##
##[][][][][]##[]....[][]####....##[]......[][][]..[]..[][]....[][]........[]........[]..[]....##..##
####################################################################################################

Answer: 1543141

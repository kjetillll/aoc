#Animate run:
#perl 2024_day_15_part_2.pl 2024_day_15_input.txt | perl -MTime::HiRes=usleep -pe'/move/&&usleep(50)'

use strict; use warnings; use v5.10; use List::Util qw(all); use feature 'signatures'; no warnings qw(experimental::signatures);

my($map,$moves) = split/\n\n/,join'',<>;
my @move = $moves=~/./g;
$map =~ s/./{'#','##','O','[]','.','..','@','@.'}->{$&}/ge; #part 2 map change
my($x,$y,$w,$n,$wx,$wy,%grid)=(0,0); for($map=~/.+/g){$grid{$x++,$y}=$_ for/./g;$w//=$x;$y++;$x=0}
($x,$y) = $map=~/@/ ? pos2xy($`) : die;
say "x: $x   y: $y   w: $w   moves: ".@move."   init map:"; say $map;

my $potential_moves = {
    '<' => sub{[$grid{$wx,  $wy  } eq ']' => $wx-1, $wy  ],
               [$grid{$wx-1,$wy  } eq ']' => $wx-1, $wy  ] },
    '>' => sub{[$grid{$wx,  $wy  } eq '[' => $wx+1, $wy  ],
               [$grid{$wx+1,$wy  } eq '[' => $wx+1, $wy  ] },
    '^' => sub{[$grid{$wx,  $wy-1} eq '[' => $wx,   $wy-1],
               [$grid{$wx,  $wy-1} eq '[' => $wx+1, $wy-1],
               [$grid{$wx,  $wy-1} eq ']' => $wx,   $wy-1],
               [$grid{$wx,  $wy-1} eq ']' => $wx-1, $wy-1] },
    'v' => sub{[$grid{$wx,  $wy+1} eq '[' => $wx,   $wy+1],
               [$grid{$wx,  $wy+1} eq '[' => $wx+1, $wy+1],
               [$grid{$wx,  $wy+1} eq ']' => $wx,   $wy+1],
               [$grid{$wx,  $wy+1} eq ']' =>, $wx-1, $wy+1] } };
for my $move (@move){
    my($dx,$dy) = @{{'>',[1,0],'<',[-1,0],'v',[0,1],'^',[0,-1]}->{$move}};
    say "--------------- move ".++$n." of ".@move."   x: $x   y: $y   move: $move";
    my @gm = gridmoves($x, $y, $potential_moves->{$move});
    if( all{ my($x,$y)=@$_; $grid{$x+$dx,$y+$dy} ne '#' } @gm ){
	push @$_, $grid{join$;,@$_} for @gm;
        for(@gm){
            my($mx,$my,$mc) = @$_;
            my $pos     = xy2pos($mx,$my);
            my $pos_new = xy2pos($mx+$dx, $my+$dy);
            substr($map,$pos_new,1) = $grid{$mx+$dx, $my+$dy} = $mc;
            substr($map,$pos,    1) = $grid{$mx,     $my    } = '.';
        }
	$x += $dx, $y += $dy if @gm
    }
    say $map;
}
say "Answer: " . eval join '+', map{my($x,$y)=/\d+/g;$x+$y*100}grep$grid{$_} eq '[',keys%grid;

sub gridmoves($x,$y,$potential_moves){
    my @work = ( [$x,$y] );
    my @m;
    while(@work){
	unshift @m, my $work = shift@work;
	($wx,$wy) = @$work;
	my @moves = grep shift@$_, &$potential_moves;
	push @work, @moves
    }
    @m
}
sub pos2xy($p){$p=length$p if$p=~/\D/;($p%($w+1),int($p/($w+1)))}
sub xy2pos($x,$y){$x+$y*($w+1)}

__END__

Run:
time perl 2024_day_15_part_2.pl 2024_day_15_input.txt |tail      # 0.24 sec

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

real    0m0,235s
user    0m0,224s
sys     0m0,052s

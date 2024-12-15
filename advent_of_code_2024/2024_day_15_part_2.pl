#Animate run:  perl 2024_day_15_part_2.pl 2024_day_15_input.txt | perl -MTime::HiRes=usleep -pe'/move/&&usleep(5e4)'

use strict; use warnings; use v5.10; use List::Util qw(all sum);
my($map,$moves) = split/\n\n/, join '', <>;
my @move = $moves =~ /./g;
$map =~ s/./{ '#'=>'##', 'O'=>'[]', '.'=>'..', '@'=>'@.' }->{$&}/ge; #part 2 map update
my($x,$y,$w,$n,%grid)=(0,0); for($map=~/.+/g){$grid{$x++,$y}=$_ for/./g;$w//=$x;$y++;$x=0}
($x,$y) = $map=~/@/ ? (length($`)%($w+1),int(length($`)/($w+1))) : die;
say "x: $x   y: $y   w: $w   moves: ".@move."   init map:"; say $map;
MOVE:
for my $move (@move){
    say "--------------- move ".++$n." of ".@move."   x: $x   y: $y   move: $move";
    my($dx,$dy) = @{ { '>'=>[1,0], '<'=>[-1,0], 'v'=>[0,1], '^'=>[0,-1] }->{$move} };
    my(@check, @gridmoves, %visited) = ([$x,$y],,);
    while( @check ){ #bfs
        my($cx, $cy) = @{shift@check};
        my $cell = $grid{$cx,$cy};
        next MOVE if $cell eq '#'; #hit wall
        next if $visited{$cx,$cy}++;
        next if index('@O[]',$cell) == -1;
        push @gridmoves, [$cx, $cy];
        push @check, [$cx+1, $cy] if $cell eq '[';
        push @check, [$cx-1, $cy] if $cell eq ']';
        push @check, [$cx+$dx, $cy+$dy];
    }
    for( reverse @gridmoves ){
        my($cx,$cy) = @$_;
        $grid{$cx+$dx, $cy+$dy} = substr($map,$cx+$dx + ($cy+$dy) * ($w+1), 1) = $grid{$cx,$cy};
        $grid{$cx,     $cy    } = substr($map,$cx     + $cy       * ($w+1), 1) = '.';
    }
    $x += $dx, $y += $dy if @gridmoves;
} continue{ say $map }
say "Answer: " . sum map{my($x,$y)=/\d+/g;$x+$y*100}grep$grid{$_}=~/O|\[/,keys%grid;

__END__

Run:
time perl 2024_day_15_part_2.pl 2024_day_15_input.txt | tail      # 0.15 sec

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

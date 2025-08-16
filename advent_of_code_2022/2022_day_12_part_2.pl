use v5.10; use strict; use warnings;

my($x, $y, $sx, $sy, $ex, $ey, %grid, %steps) = (0,0);

while( <> ){
    for( /./g ){
        ($sx, $sy) = ($x, $y) if /E/;
        $grid{$x++, $y} = height( /E/ ? 'z' : s/S/a/r );
    }
    $x=0; $y++
}

my @work = ( [$sx, $sy, 0] );

while( @work ) {

    my($x, $y, $steps) = @{ shift @work };

    last if $grid{$x,$y} == height('a') and say "Answer: $steps";

    next if ($steps{$x,$y} // 9e9) <= $steps;

    $steps{$x,$y} = $steps;

    push @work,
        grep -2 < $grid{$x,$y} - ( $grid{ $$_[0], $$_[1] } // 9e9 ),
        map [ $x + $$_[0],
              $y + $$_[1],
              $steps + 1 ],
        [1,0], [-1,0], [0,1], [0,-1];

}
sub height { 1000-ord(pop) }

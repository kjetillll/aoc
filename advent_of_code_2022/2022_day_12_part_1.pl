use v5.10; use strict; use warnings;

my($x, $y, $sx, $sy, $ex, $ey, %grid, %steps) = (0,0);

while( <> ){
    for( /./g ){
        $grid{$x, $y} = ord;
        /S/ and ($sx, $sy, $grid{$x, $y}) = ($x, $y, ord'a');
        /E/ and ($ex, $ey, $grid{$x, $y}) = ($x, $y, ord'z');
        $x++;
    }
    $x=0; $y++
}

my @work = ( [$sx, $sy, 0] );

while( @work ) {

    my($x, $y, $steps) = @{ shift @work };

    last if "$x,$y" eq "$ex,$ey" and say "Answer: $steps";

    next if ($steps{$x,$y} // 9e9) <= $steps;

    $steps{$x,$y} = $steps;

    push @work,
        grep -2 < $grid{$x,$y} - ( $grid{ $$_[0], $$_[1] } // 9e9 ),
        map [ $x + $$_[0],
              $y + $$_[1],
              $steps + 1 ],
        [1,0], [-1,0], [0,1], [0,-1];

}

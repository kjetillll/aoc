use strict; use warnings; use v5.10;
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input

say "Answer: ",
    eval
    join '+',
    map 1 + $grid{$_},
    grep {
        my($x,$y) = /\d+/g;
        my $h = $grid{$x,$y};
        not
        grep { $h >= ( $grid{ $x + $$_{dx}, $y + $$_{dy} } // 9e9 ) }
        { dx =>  1, dy =>  0 },
        { dx =>  0, dy =>  1 },
        { dx => -1, dy =>  0 },
        { dx =>  0, dy => -1 }
    }
    keys %grid;

# time perl 2021_day_09_part_1.pl 2021_day_09_input.txt    # 0.036 sec
# Answer: 603

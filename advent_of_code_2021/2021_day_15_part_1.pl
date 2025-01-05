use strict; use warnings; use v5.10; use List::BinarySearch::XS qw(binsearch_pos);

my($x,$y,$xmax,$ymax,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $xmax=$x-1;$x=0 } $ymax=$y-1; #read input

my @dir = ( { dx =>  1, dy =>  0 },
            { dx =>  0, dy =>  1 },
            { dx => -1, dy =>  0 },
            { dx =>  0, dy => -1 } );
my @work = ( [0,0,0] );
my %seen;
while( @work ){
    my($wx, $wy, $sum) = @{ shift @work};
    last if $wx == $xmax and $wy == $ymax and say "Answer: $sum";
    for( @dir ){
        my($nx, $ny) = ( $wx + $$_{dx}, $wy + $$_{dy} );
        next if !exists $grid{$nx,$ny};
        next if $seen{$nx,$ny}++;
        my $new_work = [$nx, $ny, $sum + $grid{$nx,$ny}];
        my $pos = binsearch_pos { $$a[2] <=> $$b[2] } $new_work, @work;  #prioqueue
        splice @work, $pos, 0, $new_work;
    }
}

# time perl 2021_day_15_part_1.pl 2021_day_15_input.txt   # 0.046 sec
# Answer: 537
    

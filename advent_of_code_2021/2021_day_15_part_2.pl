use strict; use warnings; use v5.10; use List::BinarySearch::XS qw(binsearch_pos);

my($x,$y,$width,$height,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $width=$x;$x=0 } $height=$y; #read input

sub gridval {
    my($x,$y) = @_;
    $grid{$x,$y} //=
    $x == -1        ? undef
  : $y == -1        ? undef
  : $x == 5*$width  ? undef
  : $y == 5*$height ? undef
  : $x >= $width    ? 1 + gridval($x-$width,$y) =~ y/9/0/r
  : $y >= $height   ? 1 + gridval($x,$y-$height) =~ y/9/0/r
  : die "wont see this";
}

my @dir = ([1,0],[-1,0],[0,1],[0,-1]);
my @work = ( [0,0,0] );
my %seen = ();

while( @work ){
    my($wx, $wy, $sum) = @{ shift @work};
    last if $wx == 5*$width-1 and $wy == 5*$height-1 and say "Answer: $sum";
    for( @dir ){
        my($nx, $ny) = ( $wx + $$_[0], $wy + $$_[1] );
        my $g = $grid{$nx,$ny} // gridval($nx,$ny);
        next if not defined $g;
        next if $seen{$nx,$ny}++;
        my $new_work = [$nx, $ny, $sum + $g];
        my $pos = binsearch_pos { $$a[2] <=> $$b[2] } $new_work, @work;  #prioqueue
        splice @work, $pos, 0, $new_work;
    }
}

# time perl 2021_day_15_part_2.pl 2021_day_15_input.txt   # 3.59 sec   *) ---> 1.25 sec with memo
# Answer: 2881

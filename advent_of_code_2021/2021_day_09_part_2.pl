use strict; use warnings; use v5.10;
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
my @dir = ([1,0],[0,1],[-1,0],[0,-1]);
my(@basin, %seen);
for( keys %grid ){
    push @basin, 0;
    my @work = ( [ /\d+/g ] );
    while( @work ){
        my($x,$y) = @{ shift @work };
        next if $seen{$x,$y}++;
        next if !exists $grid{$x,$y};
        next if $grid{$x,$y}==9;
        $basin[-1]++;
        push @work, map [ $x + $$_[0], $y + $$_[1] ], @dir;
    }
}
say "Answer: ", eval join '*', ( sort { $b <=> $a } @basin )[0,1,2];

# https://adventofcode.com/2021/day/9#part2
# time perl 2021_day_09_part_2.pl 2021_day_09_input.txt    # 0.037 sec
# Answer: 786780

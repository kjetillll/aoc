use strict; use warnings; use v5.10;
my @p = map [ /\d+/g ], <>;
my $max_area = -1;
for my $point1 (@p){
for my $point2 (@p){
    my $area = ( abs( $$point1[0] - $$point2[0] ) + 1 )
             * ( abs( $$point1[1] - $$point2[1] ) + 1 );
    $max_area = $area if $area > $max_area;
}}
say "Answer: $max_area";


# perl 2025_day_09_part_1.pl 2025_day_09_example.txt
# Answer: 50

# perl 2025_day_09_part_1.pl 2025_day_09_input.txt     # 0.043 seconds
# Answer: 4740155680

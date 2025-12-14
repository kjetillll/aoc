use v5.10;
say "Answer: ", 0 + grep { my @side = sort { $a <=> $b } /\d+/g; $side[0] + $side[1] > $side[2] } <>;

# perl 2016_day_03_part_1.pl 2016_day_03_input.txt
# Answer: 869

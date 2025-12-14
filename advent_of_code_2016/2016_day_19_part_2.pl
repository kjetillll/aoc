use v5.10; use strict; use warnings;

my $elves = 0 + <>;
my($e, $a) = (5, 2);
while($e <= $elves){
    say "Answer: $a" if $e == $elves;
    $a += $a < $e/2 ? 1 : 2;
    $a = 1 if $a > ++$e;
}

# perl 2016_day_19_part_2.pl 2016_day_19_example.txt
# Answer: 2

# perl 2016_day_19_part_2.pl 2016_day_19_input.txt     # 0.34 seconds
# Answer: 1424135

use v5.10; use strict; use warnings;

my $elfs = <>;
my $a = 3;
my $A;
for my $e ( 5 .. $elfs ){
    $A = $a;
    $a = -1 if $a >= $e;
    $a += 2
}
say "Answer: $A";

# perl 2016_day_19_part_1.pl 2016_day_19_input.txt    # 0.15 seconds
# Answer: 1842613

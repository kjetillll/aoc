use v5.10;
use List::Util qw(max sum);
use Algorithm::Combinatorics 'permutations';

/^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\./||die and $happiness{$1}{$4} = $2 eq 'gain' ? +$3 : -$3 while <>;

my @names = keys %happiness;

say "Answer: " . max map {
    my $n = $_;
    sum map $happiness{ $$n[$_] }{ $$n[ ($_+1) % @$n ] }
          + $happiness{ $$n[$_] }{ $$n[ ($_-1) % @$n ] }, 0 .. @$n-1
} permutations(\@names)

#time perl 2015_day_13_part_1.pl 2015_day_13_input.txt #0.19sec
#Answer: 709

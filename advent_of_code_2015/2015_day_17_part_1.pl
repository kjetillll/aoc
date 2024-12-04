use v5.10;
use List::Util 'sum';
use Algorithm::Combinatorics 'subsets';

my @c = map s/\s//gr, <>;
my $count = 0;
my $iter = subsets(\@c);
while( my $subset = $iter->next ){
    $count++ if sum(@$subset) == 150
}
say "Answer: $count";

#time perl 2015_day_17_part_1.pl 2015_day_17_input.txt #2.98 sec
#Answer: 1638


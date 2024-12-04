use v5.10;
use List::Util qw(sum min);
use Algorithm::Combinatorics 'subsets';

my @container = map s/\s//gr, <>;
my $count = 0;
my $iter = subsets(\@container);
my %ways;
while( my $subset = $iter->next ){
    $ways{@$subset}++ if sum(@$subset) == 150
}
say "Answer: ", $ways{min keys %ways};

#time perl 2015_day_17_part_2.pl 2015_day_17_input.txt #3.00 sec
#Answer: 17


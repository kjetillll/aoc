use v5.10;
use List::Util qw(min sum);
use Algorithm::Combinatorics 'permutations';

/(\w+) to (\w+) = (\d+)/, $dist{$1}{$2} = $dist{$2}{$1} = $3 while <>;

my @places = sort keys %dist;

say "Answer: ".min map{
    my $route = $_;
    sum map $dist{ $$route[$_] }{ $$route[$_+1] }, 0 .. @$route-2
}
permutations(\@places);

#Answer: 251

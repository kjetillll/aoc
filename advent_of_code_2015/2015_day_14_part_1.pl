use v5.10;
use List::Util qw(min max);

/(\w+) can fly (\d+) km.s for (\d+) seconds, but then must rest for (\d+) seconds\./||die and $reindeer{$1}={kmps=>$2,flytime=>$3,resttime=>$4} while <>;

for my $r (values %reindeer){
    my($time, $dist) = (2503, 0);
    while($time > 0){
        my $flytime = min($time, $$r{flytime});
        $dist += $$r{kmps} * $flytime;
        $time -= $flytime + $$r{resttime};
    }
    $$r{dist}=$dist;
}
say "Answer: ", max map $$_{dist}, values %reindeer;

#Answer: 2655

use v5.10;
use List::Util 'sum';
use Math::Prime::Util::GMP 'divisors';

my $inp = shift() // 29000000;

for my $h ( 1 .. $inp ){
    my $p = sum map 11 * $_, grep $_ * 50 >= $h, divisors($h);
    $p >= $inp and say("Answer: $h    p: $p    d: @{[divisors($h)]}"), last;
}

#time perl 2015_day_20_part_2.pl #1.88 sec
#Answer: 705600

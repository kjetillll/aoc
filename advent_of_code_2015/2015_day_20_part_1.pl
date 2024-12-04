use v5.10;
use Math::Prime::Util::GMP 'sigma';
my $inp = shift() // 29000000;
10 * sigma($_) >= $inp and say("Answer: $_"),last for 1 .. $inp;

#time perl 2015_day_20_part_1.pl $(cat 2015_day_20_input.txt)   #0.52 sec
#Answer: 665280

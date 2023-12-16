use strict;
use warnings;
use v5.10;
sub lcm { my($a,$b,@r)=@_; @r ? lcm($a,lcm($b,@r)) : $a*$b/gcd($a,$b) }
sub gcd { my($a,$b,@r)=@_; @r ? gcd($a,gcd($b,@r)) : $b==0 ? $a : gcd($b, $a % $b) }
my@i=split//,<>=~/\w+/?$&:die; #instructions
my %n; /(\w+).*?(\w+).*?(\w+)/ and $n{$1}={L=>$2,R=>$3} for <>;
my @s = map{ my $step=0; $_=$n{$_}{$i[$step++%@i]} while !/Z$/; $step } grep/A$/, sort keys%n;
say "nodes: ".(keys%n)."   instructions: ".@i."   solution: lcm(@{[join',',@s]}) = ".lcm(@s);
__END__
time perl 2023_day_8_part_2_better.pl 2023_day_8_input.txt  #0.035 sekunder
nodes: 750   instructions: 263   solution: lcm(20777,15517,13939,17621,18673,11309) = 13289612809129

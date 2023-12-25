#https://adventofcode.com/2023/day/2 - del 1
#
#kjør enten:
#
#  perl -nE'say$t+=!eval(join"+",map{s/r|g|b/">".{qw(r 12 g 13 b 14)}->{$&}/eg;eval||0}/\d+ [rgb]/g)*s/\w+//r' 2023_day_02_ex.txt    | tail -1 # => 8
#  perl -nE'say$t+=!eval(join"+",map{s/r|g|b/">".{qw(r 12 g 13 b 14)}->{$&}/eg;eval||0}/\d+ [rgb]/g)*s/\w+//r' 2023_day_02_input.txt | tail -1 # => 2377
#
#eller
#
# perl 2023_day_02.pl 2023_day_01_ex.txt           # 8
# perl 2023_day_02.pl 2023_day_01_input.txt        # 2377

while(<>){
    $t += !eval( join '+',
		 map {
		     s/r|g|b/">".{qw(r 12 g 13 b 14)}->{$&}/eg;
		     eval||0
		 } /\d+ [rgb]/g
	       ) * s/\w+//r;
}
print "svar: $t\n";

my %t = qw(AND & OR | LSHIFT << RSHIFT >> NOT 65535-);
eval s!(.*) -> (\w+)!"sub F$2 {\$m{'$2'}//=".$1=~s/[A-Z]+/$t{$&}/r=~s/[a-z]+/F$&()/gr."}"!er while <>;
eval "sub Fb{".Fa()."}";
%m=();
print "Answer: ", Fa(), "\n";

#Run:
#perl 2015_day_07_part_2.pl 2015_day_07_input.txt
#Answer: 40149

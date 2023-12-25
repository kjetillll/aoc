#https://adventofcode.com/2023/day/2 - del 2
#
#kjør enten:
#
#  perl -MList::Util=max -nE'my%m;push@{$m{$2}},$1 while s/(\d+) (\w)//;say$t+=eval join"*",map max(@$_),values%m' 2023_day_02_ex.txt | tail -1
#  perl -MList::Util=max -nE'my%m;push@{$m{$2}},$1 while s/(\d+) (\w)//;say$t+=eval join"*",map max(@$_),values%m' 2023_day_02_input.txt | tail -1
#
#eller
#
# perl 2023_day_02_part_2.pl 2023_day_01_ex.txt           # 2286
# perl 2023_day_02_part_2.pl 2023_day_01_input.txt        # 71220

use List::Util 'max';
while(<>){
    my %m;
    push @{$m{$2}}, $1 while s/(\d+) (\w)//;
    $t += eval join '*', map max(@$_), values %m;
}
print "svar: $t\n";

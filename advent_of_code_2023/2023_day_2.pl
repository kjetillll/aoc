perl -MList::Util=max -nE'my%m;push@{$m{$2}},$1 while s/(\d+) (\w)//;say$t+=eval join"*",map max(@$_),values%m' 2023_day_2_input.txt|tail -1

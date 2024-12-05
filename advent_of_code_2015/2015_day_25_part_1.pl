use v5.10;

my($row,$col) = <> =~ /\d+/g;

say "Search for row=$row col=$col";

my($r, $c, $code) = (1, 1, 20151125);

$code = $code * 252533 % 33554393,
($r,$c) = $r==1 ? ($c+1,1) : ($r-1,$c+1)
    until $r==$row and $c==$col;

say "Answer: $code";

#time perl 2015_day_25_part_1.pl 2015_day_25_input.txt  #1.85 sec
#Answer: 8997277

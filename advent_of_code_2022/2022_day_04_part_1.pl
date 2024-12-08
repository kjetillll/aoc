print "Answer: ", 0 + grep{ my($a,$b,$c,$d) = /\d+/g; $a<=$c and $b>=$d or $c<=$a && $d>=$b } <>;

#Run:
#perl 2022_day_04_part_1.pl 2022_day_04_input.txt
#Answer: 509

#print "Answer: ", 0 + grep{ my($a,$b,$c,$d) = /\d+/g; $a<=$c and $c<=$b or $c<=$a and $d>=$a } <>; #hm
print "Answer: ", 0 + grep{ my($a,$b,$c,$d) = /\d+/g; my%set=map{$_=>1}$a..$b,$c..$d; ($b-$a+1) + ($d-$c+1) != 0+keys%set } <>;

#Run:
#perl 2022_day_04_part_2.pl 2022_day_04_input.txt
#Answer: 870

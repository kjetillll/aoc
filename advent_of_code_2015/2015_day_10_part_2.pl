my $num = shift() // '3113322113';
$num =~ s/(.)\1*/length($&).$1/eg, print "$_: ".length($num)."\n" for 1..50;
print "Answer: ".length($num)."\n";

#time perl 2015_day_10_part_2.pl $(cat 2015_day_10_input.txt) #3.36sec
#Answer: 4666278

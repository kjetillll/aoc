my $input = join '', <>;
my $sum = eval join '+', map{my($a,$b)=/\d+/g;$a*$b} $input =~ /mul\(\d{1,3},\d{1,3}\)/g;
print "Answer: $sum\n";

#Answer: 165225049

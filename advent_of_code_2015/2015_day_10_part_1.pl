my $num = shift() // '3113322113';
$num =~ s/(.)\1*/length($&).$1/eg for 1..40;
print "Answer: ".length($num)."\n";

#Answer: 329356

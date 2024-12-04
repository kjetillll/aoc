my $pw = shift() // 'hxbxwxba';
my $re3 = join '|', map substr(join('', 'a' .. 'z'), $_, 3), 0 .. 23;
$pw++ until
  $pw =~ /$re3/ and
  $pw !~ /[iol]/ and
  $pw =~ /(.)\1.*(.)\2/ and
  ++$n == 2;

print "Answer: $pw\n";

#perl 2015_day_11_part_2.pl $(cat 2015_day_11_input.txt
#Answer: hxcaabcc

use Digest::MD5 'md5_hex';
my $n = 0;
my $input = shift() // "iwrupvqb";
md5_hex($input . ++$n) =~ /^0{6}/ and print "Answer: $n\n" and exit while 1;

#Answer: 9958218

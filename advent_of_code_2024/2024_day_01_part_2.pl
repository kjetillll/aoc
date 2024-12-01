my @inp=<>;
my %times; $times{$_}++ for map /\d+$/g, @inp;
printf "Result: %d\n", eval join '+', map $_ * $times{$_}, map /^\d+/g, @inp;
__END__
Run:
perl 2024_day_01_part_2.pl 2024_day_01_input.txt 
Result: 23927637

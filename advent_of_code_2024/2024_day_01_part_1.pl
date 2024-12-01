my @inp=<>;
my @a=sort{$a<=>$b}map/^\d+/g,@inp;
my @b=sort{$a<=>$b}map/\d+$/g,@inp;
printf "Result: %d\n", eval join'+', map abs($_-shift@b), @a;
__END__
Run:
perl 2024_day_01_part_1.pl 2024_day_01_input.txt 
Result: 2815556

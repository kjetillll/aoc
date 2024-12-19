use v5.10;
my @inp = <>;
my @pat = shift(@inp)=~/\w+/g;
my $re = join'|',@pat; $re="^($re)+\$";
say "re: <$re>";
shift@inp;
/$re/ and $a++ for @inp;
say "Answer: $a";

# time perl 2024_day_19_part_1.pl 2024_day_19_example.txt
# time perl 2024_day_19_part_1.pl 2024_day_19_input.txt       # ?.?? sec
# Answer: 369

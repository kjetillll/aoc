use v5.10;
sub is_abba { pop() =~ /(.)(.)\2\1/ and $1 ne $2 }
say "Answer: $_", 0 + grep { my $inside=''; is_abba(s/\[\w+\]/$inside.=$&;" "/ger) && !is_abba($inside) } <>;

# perl 2016_day_07_part_1.pl 2016_day_07_example.txt
# Answer: 2

# perl 2016_day_07_part_1.pl 2016_day_07_input.txt
# Answer: 105

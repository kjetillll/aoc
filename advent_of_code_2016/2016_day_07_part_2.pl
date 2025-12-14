use v5.10;
sub trigrams { map substr($_[0], $_, 3), 0 .. length($_[0]) - 3 }
sub abas { grep / (\w) (\w) \1 /x && $1 ne $2, &trigrams }
say "Answer: $_" . grep {
    my $inside = '';
    s{ \[ \w+ \] }{ $inside .= $&; ' ' }xge;
    0 + grep /(.)(.)/ && $inside =~ /$2$1$2/, abas($_)
} <>;

# perl 2016_day_07_part_2.pl 2016_day_07_example_part_2.txt
# Answer: 3

# perl 2016_day_07_part_2.pl 2016_day_07_input.txt
# Answer: 258

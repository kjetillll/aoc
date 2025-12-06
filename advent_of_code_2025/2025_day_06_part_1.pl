$i=0, map { push @{ $l[$i++] }, $_ } /\S+/g while <>;
print "Answer: ", eval join '+', map { eval join pop(@$_), @$_ } @l;



# perl 2025_day_06_part_1.pl  2025_day_06_example.txt
# Answer: 4277556

# perl 2025_day_06_part_1.pl  2025_day_06_input.txt
# Answer: 4722948564882

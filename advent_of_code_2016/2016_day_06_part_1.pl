my(@fr, $i);
$i = 0, map $fr[ $i++ ]{ $_ }++, /./g while <>;
print map { (sort {$$_{$b} <=> $$_{$a}} keys %$_)[0] } @fr;

# perl 2016_day_06_part_1.pl  2016_day_06_example.txt   # outputs: easter
# perl 2016_day_06_part_1.pl  2016_day_06_input.txt     # outputs: bjosfbce

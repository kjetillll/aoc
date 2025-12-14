my(@fr, $i);
$i = 0, map $fr[ $i++ ]{ $_ }++, /./g while <>;
print map { (sort {$$_{$a} <=> $$_{$b}} keys %$_)[0] } @fr;

# perl 2016_day_06_part_2.pl  2016_day_06_example.txt   # outputs: advent
# perl 2016_day_06_part_2.pl  2016_day_06_input.txt     # outputs: veqfxzfx

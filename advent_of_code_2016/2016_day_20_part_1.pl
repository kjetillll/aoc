my @lst = sort { $$a[0] <=> $$b[0] } map [ /\d+/g ], <>;
while( @lst > 1 and $lst[0][1] >= $lst[1][0] - 1 ){
    my($a, $b) = splice @lst, 0, 2;
    unshift @lst, [ $$a[0], $$b[1] > $$a[1] ? $$b[1] : $$a[1] ];
}
print "Answer: ", $lst[0][1] + 1, "\n";

# perl 2016_day_20_part_1.pl  2016_day_20_input.txt      # 0.008 seconds
# Answer: 22887907

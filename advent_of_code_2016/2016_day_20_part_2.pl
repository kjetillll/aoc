use v5.10; use strict; use warnings;

my @lst = sort { $$a[0] <=> $$b[0] } map [ /\d+/g ], <>;

say "list size: ".@lst;

my @lst_fixed;

while( @lst ){
    while( @lst > 1 and $lst[0][1] >= $lst[1][0] - 1 ){
        my($a, $b) = splice @lst, 0, 2;
        unshift @lst, [ $$a[0], $$b[1] > $$a[1] ? $$b[1] : $$a[1] ];
    }
    push @lst_fixed, shift @lst
}
say "fixed list size: ".@lst_fixed;
say "Answer part 1: ", $lst_fixed[0][1] + 1;
say "Answer part 2: ", eval join '+', map $lst_fixed[$_+1][0] - $lst_fixed[$_][1] - 1, 0 .. $#lst_fixed - 1

# perl 2016_day_20_part_2.pl  2016_day_20_input.txt      # 0.01 seconds
# Answer part 1: 22887907
# Answer part 2: 109

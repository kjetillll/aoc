use strict; use warnings; use v5.10;

say "Answer: ",
    eval
    join '+',
    map $$_[1] - $$_[0] + 1,
    fix_ranges(
        map [/\d+/g],
        split /\n/,
        ( split /\n\n/, join '', <> )[0]
    );

sub fix_ranges {
    my @r = sort { $$a[0] <=> $$b[0] } @_;
    my @r_fixed;
    while(@r){
        while( @r > 1 and $r[0][1] >= $r[1][0] - 1 ){
            my($a, $b) = splice @r, 0, 2;
            unshift @r, [ $$a[0], $$b[1] > $$a[1] ? $$b[1] : $$a[1] ];
        }
        push @r_fixed, shift @r;
    }
    @r_fixed
}

# perl 2025_day_05_part_2.pl 2025_day_05_example.txt
# Answer: 14    

# perl 2025_day_05_part_2.pl 2025_day_05_input.txt     # 0.008 seconds
# Answer: 352340558684863
    

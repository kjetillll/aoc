use strict; use warnings; use v5.10;
my($x, $y, %s, %b) = (0, 0);
while( <> ){
    for( /./g ){
        $b{$x} = 1 if /S/;
        $s{$x, $y} = 0 if /\^/;
        $x++;
    }
    ($x, $y) = (0, $y+1)
}
for my $y ( 0 .. $y ){
    my @x = grep exists $s{$_, $y}, keys %b;
    $s{$_, $y} = 1 for @x;
    @b{$_-1, $_+1} = () for @x;
    delete @b{@x};
}
say "Answer: ", eval join '+', values %s;

# perl 2025_day_07_part_1.pl 2025_day_07_example.txt
# Answer: 21

# perl 2025_day_07_part_1.pl 2025_day_07_input.txt     # 0.05 seconds
# Answer: 1681

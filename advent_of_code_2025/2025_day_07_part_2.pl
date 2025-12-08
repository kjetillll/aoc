use strict; use warnings; use v5.10;
my($x, $y, %s, %b) = (0, 0);  #%b = beams there now, %s = splitter
while( <> ){
    for( /./g ){
        $b{$x} = 1 if /S/;
        $s{$x, $y} = 1 if /\^/;
        $x++
    }
    ($x, $y) = (0, $y+1)
}
for my $y ( 0 .. $y ){
    my @x = grep $s{$_, $y}, keys %b;
    $b{$_-1} += $b{$_} for @x;
    $b{$_+1} += $b{$_} for @x;
    delete @b{@x}
}
say "Answer: ", eval join '+', values %b;

# perl 2025_day_07_part_2.pl 2025_day_07_example.txt
# Answer: 40

# perl 2025_day_07_part_2.pl 2025_day_07_input.txt     # 0.015 seconds
# Answer: 422102272495018
    

use strict; use warnings; use v5.10;
my($x, $y, %grid) = (0, 0);
my @adj = ( [-1,-1], [-1,0], [-1,1],
            [0,-1],          [0,1],
            [1,-1],  [1,0],  [1,1] );
while(<>){
    ++$x and /\@/ and $grid{$x,$y}=1 for/./g;
    ++$y; $x = 0;
}
my $count = 0;
for(keys %grid){
    my($x, $y) = /\d+/g;
    my @adj = grep $grid{ $x + $$_[0], $y + $$_[1] }, @adj;
    $count++ if @adj < 4;
}
print 0+keys%grid," <-- cells\n";
say "Answer: $count";

# perl 2025_day_04_part_1.pl 2025_day_04_example.txt
# Answer: 13

# perl 2025_day_04_part_1.pl 2025_day_04_input.txt     # 0.06 seconds
# Answer: 1549

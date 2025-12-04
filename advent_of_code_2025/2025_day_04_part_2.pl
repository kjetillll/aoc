use strict; use warnings; use v5.10;
my($x, $y, %grid) = (0, 0);
my @adj = ( [-1,-1], [-1,0], [-1,1],
            [0,-1],          [0,1],
            [1,-1],  [1,0],  [1,1] );
while(<>){
    ++$x and /\@/ and $grid{$x,$y}=1 for/./g;
    ++$y;
    $x = 0;
}
my $count = 0;
while(1){
    my @remove;
    for(keys %grid){
        my($x, $y) = /\d+/g;
        my @adj = grep $grid{ $x + $$_[0], $y + $$_[1] }, @adj;
        ++$count and push@remove, $_ if @adj < 4;
    }
    delete @grid{ @remove };
    say "Remove ".@remove if $ENV{VERBOSE};
    last if !@remove;
}
say "Answer: $count";


# perl 2025_day_04_part_2.pl 2025_day_04_input.txt     # 1.19 seconds
# Answer: 8887

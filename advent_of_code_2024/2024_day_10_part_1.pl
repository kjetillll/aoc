use v5.10;
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input

say "Answer: " . eval join '+', map {
    my($startx, $starty) = /\d+/g;
    my @try = ( [$startx, $starty, 0] );
    my %path9;
    while(@try){
        my $t = shift @try;
        my($x, $y, $h) = @$t;
        $path9{$x, $y}++, next if $h == 9;
        push @try,
            grep $grid{$$_[0], $$_[1]} == $h+1,
            [$x-1, $y,   $h+1],
            [$x+1, $y,   $h+1],
            [$x,   $y-1, $h+1],
            [$x,   $y+1, $h+1]
    }
    0 + keys %path9
}
grep $grid{$_} == 0,
keys %grid;

#Answer: 472

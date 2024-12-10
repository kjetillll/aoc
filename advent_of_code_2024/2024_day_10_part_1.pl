use v5.10;
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input

say "Answer: " . eval join '+', map {
    my($startx, $starty) = /\d+/g;
    my @try = ( [$startx, $starty, 0] );
    my %path9;
    while(@try){
	my $t = shift @try;
	my($x, $y, $h) = @$t;
	$path9{$x, $y}++ if $h == 9;
	push @try, map [ @$_, $h+1 ],
                   grep $grid{join $;, @$_} == $h+1,
	           [$x-1,$y], [$x+1,$y], [$x,$y-1], [$x,$y+1];
    }
    0 + keys%path9
}
grep $grid{$_} == 0,
keys %grid;

#Answer: 472

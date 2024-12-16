use v5.10; use List::Util qw(max);
while(<>){
    my($x1, $y1, $x2, $y2) = /\d+/g;
    my $dx = $x2 <=> $x1;
    my $dy = $y2 <=> $y1;
    my $diff = max( abs($x2-$x1), abs($y2-$y1) );
    $grid{$x1+$dx*$_,$y1+$dy*$_}++ for 0 .. $diff;
}
say "Answer: " . grep $grid{$_} >= 2, keys %grid;
#Answer: 19676

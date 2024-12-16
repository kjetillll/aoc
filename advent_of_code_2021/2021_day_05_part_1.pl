use v5.10;
while(<>){
    my($x1, $y1, $x2, $y2) = /\d+/g;
    if( $x1 == $x2 ){ $grid{$x1,$_}++ for $y1..$y2, $y2..$y1 }
    if( $y1 == $y2 ){ $grid{$_,$y1}++ for $x1..$x2, $x2..$x1 }
}
say "Answer: " . grep $grid{$_} >= 2, keys %grid;
#Answer: 7414

while(<>){
    my($op, $x1, $y1, $x2, $y2) = /(n|f|e) (\d+),(\d+) through (\d+),(\d+)/;
    for my $x ( $x1 .. $x2 ){
	for my $y ( $y1 .. $y2 ){
	    $light{$x,$y} = $op eq 'f' ? 0
		          : $op eq 'n' ? 1
		          : $op eq 'e' ? 1 - $light{$x,$y}
	                  : die;
	}
    }
}
print "Answer: ", 0 + grep $light{$_}==1, keys %light;

#Answer: 377891

while(<>){
    my($op, $x1, $y1, $x2, $y2) = /(n|f|e) (\d+),(\d+) through (\d+),(\d+)/;
    for my $x ( $x1 .. $x2 ){
        for my $y ( $y1 .. $y2 ){
            $light{$x,$y} += $op eq 'f' ? $light{$x,$y} ? -1 : 0
                           : $op eq 'n' ? 1
                           : $op eq 'e' ? 2
                           : die
        }
    }
}
print "Answer: ", eval join '+', values %light;

#Answer: 14110788

for(split/\n\n/,join'',<>){
    my($ax,$ay,$bx,$by,$x,$y) = /\d+/g;
    print "---------------\n$_\n";
    for my $a (1..100){
    for my $b (1..100){
        if( $a*$ax + $b*$bx == $x
        and $a*$ay + $b*$by == $y )
        {
            print "a: $a   b: $b\n";
            $tokens += $a*3 + $b*1;
        }
    }}
}
print "Answer: $tokens\n";

#Answer: 29201

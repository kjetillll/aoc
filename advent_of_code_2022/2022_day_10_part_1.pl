my($c,$x,$s) = (0,1,0);

for( map { /noop/ ? $_ : ('noop', $_) } <> ){
    $c++;
    $s += $c * $x if $c % 40 == 20;
    $x += $1 if /addx (\S+)/;
}
print "Answer: $s\n";

#Answer: 13860

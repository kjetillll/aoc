my($x,$y) = (0,0);
my %gh; #gifted house
$gh{0,0} = 1;

for( <> =~ /./g ){
    $x += /</  ? -1 : />/ ? 1 : 0;
    $y += /\^/ ? -1 : /v/ ? 1 : 0;
    $gh{$x,$y} = 1;
}

print "Answer: ",  0 + keys %gh, "\n";

#Answer: 2081

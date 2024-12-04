my($x,$y,$rx,$ry) = (0,0,0,0);
my %gh; #gifted house
$gh{0,0} = 1;

for( <> =~ /./g ){
    $x += /</  ? -1 : />/ ? 1 : 0;
    $y += /\^/ ? -1 : /v/ ? 1 : 0;
    $gh{$x,$y} = 1;
    ($x,$y,$rx,$ry) = ($rx,$ry,$x,$y); #swap pos with robo
}

print 0 + keys %gh, "\n";

#2341

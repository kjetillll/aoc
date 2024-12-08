use v5.10; use List::Util qw(first max);

my($x,$y,%grid) = (0,0);
while(<>){ $grid{$x++,$y} = 100+$_ for /\d/g; $x=0; $y++}
my $w = sqrt keys %grid;

say "Answer: ", max map {
    my($x,$y) = /\d+/g;
    my $h = $grid{$x,$y};
    my $u; first { $u++; $grid{$x,$_} >= $h } reverse 0    .. $y-1;
    my $d; first { $d++; $grid{$x,$_} >= $h }         $y+1 .. $w-1;
    my $l; first { $l++; $grid{$_,$y} >= $h } reverse 0    .. $x-1;
    my $r; first { $r++; $grid{$_,$y} >= $h }         $x+1 .. $w-1;
    $u * $d * $l * $r;
}
keys %grid;

#Answer: 235200

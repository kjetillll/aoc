use v5.10; use List::Util qw(max);
use Acme::Tools qw(ansicolor);

my($x,$y,%grid)=(0,0);
while(<>){$grid{$x++,$y}=100+$_ for/\d/g;$x=0;$y++}
my $w=sqrt keys%grid;

my $visible = 0;
for(sort keys%grid){
    my($x,$y)=/\d+/g;
    my $h = $grid{$x,$y};
    my @u = map $grid{$x,$_}, 0    .. $y-1;
    my @d = map $grid{$x,$_}, $y+1 .. $w-1;
    my @l = map $grid{$_,$y}, 0    .. $x-1;
    my @r = map $grid{$_,$y}, $x+1 .. $w-1;
    $visible++ if $h > max(@u)
	       or $h > max(@d)
	       or $h > max(@l)
	       or $h > max(@r);
}

say "Answer: $visible";

#Answer: 1825

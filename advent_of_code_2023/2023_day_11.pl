# https://adventofcode.com/2023/day/11 - del 1
# kjør:
#
# perl 2023_day_11.pl 2023_day_11_ex.txt     # svar: 374                   0.002 sek
# perl 2023_day_11.pl 2023_day_11_input.txt  # svar: 9693756               0.15 sek

$_ = join'',<>;        #  print s/\n/<\n/gr;
$_ = expand($_);       #  print s/\n/<\n/gr;
$_ = transpose($_);    #  print s/\n/<\n/gr;
$_ = expand($_);       #  print s/\n/<\n/gr;
$_ = transpose($_);    #  print s/\n/<\n/gr;

my $w = /.*/ ? 1+length$& : die; #print "width: $w\n";
my @g = pos_galakser($_);
my @par;
for my $i (0 .. $#g-1){ for my $j ($i+1 .. $#g){ push @par, [@g[$i,$j]] } }

printf "svar: %d\n", eval join '+', map dist(@$_), @par;

sub pos2xy {
    my $pos = shift;
    ( int($pos/$w), $pos%$w );
}
sub dist {
    my($pos1,$pos2) = @_;
    my($x1,$y1,$x2,$y2) = map pos2xy($_), $pos1, $pos2;
    abs($x2-$x1) + abs($y2-$y1)
}
sub pos_galakser {
    my $s = shift;
    grep substr($s, $_, 1) eq '#', 0 .. length $s;
}
sub expand {
    my $s = shift;
    $s =~ s/^\.+\n/$&$&/gmr
}
sub transpose {
    my $s = shift;
    my $w = /.*/?length$&:die;
    my @s;
    for(split /\n/, $s){
        my $i = 0;
        $s[$i++] .= $_ for split//;
    }
    join "", map "$_\n", @s;
}

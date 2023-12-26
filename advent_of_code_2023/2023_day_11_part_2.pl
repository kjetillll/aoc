# https://adventofcode.com/2023/day/11 - del 2
# kjør:
#
# perl 2023_day_11_part_2.pl 2023_day_11_input.txt  # svar: 717878258016               0.75 sek

$_ = join'',<>;    print s/\n/<\n/gr;  info($_);
my $ekspander = 1_000_000;
my %tomrad = map { ($_ => $ekspander) } tomme_linjer( $_);
my %tomkol = map { ($_ => $ekspander) } tomme_linjer( transpose($_) );

my $w = /.*/ ? 1+length$& : die;
print "width: $w\n";
my @g = pos_galakser($_);
my @par;
for my $i (0 .. $#g-1){
    for my $j ($i+1 .. $#g){
        push @par, [@g[$i,$j]];
    }
}

printf "svar: %d\n", eval join '+', map dist(@$_), @par;

sub tomme_linjer {
    my $s = shift;
    my $i = 0;
    map $$_[0], grep { $$_[1] =~ /^\.+$/ } map [$i++, $_], split /\n/, $s;
}
sub pos2xy{
    my $pos = shift;
    ( int($pos / $w), $pos % $w );
}
sub dist {
    my($pos1, $pos2) = @_;
    my($x1, $y1, $x2, $y2) = map pos2xy($_), $pos1, $pos2;
    ($x1,$x2) = ($x2,$x1) if $x2 < $x1;
    ($y1,$y2) = ($y2,$y1) if $y2 < $y1;
    my $dist = 0;
    for( $x1+1 .. $x2 ){ $dist += $tomrad{$_} // 1 }
    for( $y1+1 .. $y2 ){ $dist += $tomkol{$_} // 1 }
    $dist
}
sub pos_galakser {
    my $s = shift;
    grep substr($s, $_, 1) eq '#', 0 .. length $s;
}
sub info {
    my $s = shift;
    printf "linjer: %d\n", 0 + grep /\S/, split /\n/, $s;
    printf "width: %d\n", $s =~ /.*/ ? length$& : die;
    printf "lengde: %d\n", length$s;
}
sub expand {
    my $s = shift;
    $s =~ s/^\.+\n/$&$&/gmr
}
sub transpose {
    my $s = shift;
    my $w = $s=~/.*/ ? length$& : die;
    my @s;
    for( split /\n/, $s ){
        my $i = 0;
        $s[ $i++ ] .= $_ for split //;
    }
    join "", map "$_\n", @s;
}

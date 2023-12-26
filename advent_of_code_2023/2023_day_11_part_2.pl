# https://adventofcode.com/2023/day/11 - del 2
# kjør:
#
# perl 2023_day_11_part_2.pl 2023_day_11_input.txt   # svar: 717878258016               0.75 sek

use List::Util 'sum'; use Algorithm::Combinatorics 'combinations'; use strict; use warnings; use v5.10;

my $kart = join'', <>;                               # $kart = slurp universet
my $span_empty = 1_000_000;                          # bruk 2 for day 11 part 1
my @rad_span = linje_span( $kart );                  # ikke-tomme rader blir 1, tomme blir 1e6
my @kol_span = linje_span( transpose($kart) );       # ikke-tomme kolonner blir 1, tomme blir 1e6

my $wi = $kart=~/.*/ ? 1+length$& : die;             # width
my @galpos = posisjoner($kart,'#');                  # finn posisjonene til galaksene
my @par = combinations(\@galpos, 2);

say "svar: ", sum grep defined, map dist(@$_), @par; # hm grep defined

sub linje_span { map /#/ ? 1 : $span_empty, split /\n/, shift }
sub pos2xy     { my($pos,$wi) = @_; ( int($pos / $wi), $pos % $wi ) }
sub posisjoner { my($s,$t) = @_; my @p; $s =~ s/$t/ push @p, pos$s; $& /ge; @p }
sub dist {
    my($x1,$y1, $x2,$y2) = map pos2xy($_,$wi), @_;
    sum ( map $rad_span[$_], $x1<$x2 ? ($x1+1..$x2) : ($x2+1..$x1) ),
        ( map $kol_span[$_], $y1<$y2 ? ($y1+1..$y2) : ($y2+1..$y1) )
}
sub transpose {
    my($s, @t) = @_;
    for( split /\n/, $s ){ my $i = 0; $t[ $i++ ] .= $_ for split // }
    join "", map "$_\n", @t;
}

# https://adventofcode.com/2023/day/11 - del 2
# kjør:
#
# perl 2023_day_11_part_2.pl 2023_day_11_input.txt  # svar: 717878258016               0.75 sek

# perl 2023_day_11_part_2_ryddet.pl 2023_day_11_input.txt    # 1.3 sek => 717878258016

use v5.10; use List::Util 'sum'; use Algorithm::Combinatorics 'combinations';

$_ = join'',<>;                            # $_ = slurp universet
my $span_empty = 1_000_000;                # bruk 2 for day 11 part 1
my @rad_span = linje_span($_);              # ikke-tomme rader blir 1, tomme blir 1e6
my @kol_span = linje_span( transpose($_) ); # ikke-tomme kolonner blir 1, tomme blir 1e6

my $wi = /.*/ ? 1+length$& : die;          # width
my @galpos = posisjoner($_,'#');           # finn posisjonene til galaksene
my @par = combinations(\@galpos, 2);
say "svar: ", sum map dist(@$_), @par;

sub linje_span { map /#/ ? 1 : $span_empty, split /\n/, shift }
sub pos2xy     { my($pos,$wi) = @_; ( int($pos / $wi), $pos % $wi ) }
sub posisjoner { my @p; $_[0] =~ s/$_[1]/push@p,pos;$&/ge; @p }
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

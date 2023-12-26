# perl 2023_day_11_part_2_ryddet.pl 2023_day_11_input.txt    # 1.3 sek => 717878258016

use v5.10;
use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations);

$_=join'',<>;                          # $_ = slurp universet
my $span_empty=1_000_000;              # bruk 2 for day 11 part 1
my @row_span=line_span($_);            # ikke-tomme rader blir 1, tomme blir 1e6
my @col_span=line_span(transpose($_)); # ikke-tomme kolonner blir 1, tomme blir 1e6

my $wi=/.*/?1+length$&:die;            # width
my @galpos=posisjoner($_,'#');         # finn posisjonene til galaksene
my @par=combinations(\@galpos,2);
say sum map dist(@$_),@par;

sub line_span {
    map /#/ ? 1 : $span_empty, split /\n/, shift
}
sub pos2xy {
    my($pos,$wi)=@_; (int($pos/$wi), $pos%$wi)
}
sub dist {
    my($x1,$y1, $x2,$y2) = map pos2xy($_,$wi), @_;
    sum ( map $row_span[$_], $x1<$x2 ? ($x1+1..$x2) : ($x2+1..$x1) ),
        ( map $col_span[$_], $y1<$y2 ? ($y1+1..$y2) : ($y2+1..$y1) )
}
sub posisjoner {
    my@p; $_[0]=~s/$_[1]/push@p,pos;$&/ge; @p
}
sub transpose {
    my $s=shift;
    my @t;
    for(split/\n/,$s){
        my $i=0;
        $t[$i++].=$_ for split//;
    }
    join"",map"$_\n",@t;
}

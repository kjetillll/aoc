# https://adventofcode.com/2023/day/8 - del 2
# kjør:
#
# perl 2023_day_09.pl 2023_day_09_ex.txt     # svar: 114
# perl 2023_day_09.pl 2023_day_09_input.txt  # svar: 1819125966          0.038 sek

sub lst {
    my $ikke0_finnes = grep $_, @_;  print "    @_ -> \n";
    $ikke0_finnes ? ( @_, $_[-1] + ( lst(map{$_[$_]-$_[$_-1]}1..$#_) )[-1] ) : (@_,0)
}

printf "svar: %d\n", eval join '+', map { (lst(/-?\d+/g))[-1] } <>;

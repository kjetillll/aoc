# https://adventofcode.com/2023/day/7 - del 1
# kjør:
#
# perl 2023_day_07.pl 2023_day_07_ex.txt     # svar: 6440              0.03 sek
# perl 2023_day_07.pl 2023_day_07_input.txt  # svar: 250347426         0.06 sek

use List::Util qw(sum); use strict; use warnings; use v5.10;

sub ty {
    my %c; $c{$_}++ for split//, pop;
    {5=>7, 14=>6, 23=>5, 113=>4, 122=>3, 1112=>2, 11111=>1}->{join '', sort values %c}
}

my %st; @st{qw(A K Q J T 9 8 7 6 5 4 3 2)} = reverse 2..14;
my @l = map {
    my($hand, $bid) = /\w+/g;
    my $type = ty($hand);
    my @sts = map 1e3+$st{$_},split//, $hand;
    my $o = "$type ".join(' ',@sts);
    { hand=>$hand, type=>$type, bid=>$bid, o=>$o }
} <>;

my $rank=0;
@l = map { $$_{rank} = ++$rank; $_} sort { $$a{o} cmp $$b{o} } @l;

say sprintf"bid: %3d   hand: %s   o: %-25s   rank: %d   type: %d",
    @$_{qw(bid hand o rank type)} for @l;

say "svar: ", sum map { $$_{rank} * $$_{bid} } @l;

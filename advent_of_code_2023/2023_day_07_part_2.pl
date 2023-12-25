# https://adventofcode.com/2023/day/7 - del 2
# kjør:
#
# perl 2023_day_07_part_2.pl 2023_day_07_ex.txt     # svar: 5905           0.006 sek
# perl 2023_day_07_part_2.pl 2023_day_07_input.txt  # svar: 251224870      0.28 sek

use List::Util qw(sum max); use strict; use warnings; use v5.10;

my @lab = qw(A K Q   T 9 8 7 6 5 4 3 2 J);  #label
my %st; @st{@lab} = reverse 2..14;

sub ty {
    my %c; $c{$_}++ for split//, pop;
    {5=>7, 14=>6, 23=>5, 113=>4, 122=>3, 1112=>2, 11111=>1}->{join '', sort values %c}
}

sub tyj {
    my $h = shift;
    return 7 if $h eq 'JJJJJ';
    my @g;
    my $g = join ',', @lab;
    $g = $h =~ s/J/{$g}/gr;
    @g = glob $g;
    my $ty = max map ty($_), @g;
    $ty;
}

my @l = sort { $$a{o} cmp $$b{o} }
        map {
            my($hand, $bid) = /\w+/g;
            my $type = tyj($hand);
            my @sts = map 1e3 + $st{$_}, split //, $hand;
            { hand=>$hand, type=>$type, bid=>$bid, o=>"$type @sts" }
        } <>;

$l[$_-1]{rank} = $_ for 1..@l;

say sprintf "bid: %3d   hand: %s   o: %-25s   rank: %4d   type: %d",
    @$_{qw(bid hand o rank type)} for @l;

say "svar: ", sum map{ $$_{rank} * $$_{bid} } @l;

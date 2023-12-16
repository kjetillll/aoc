use v5.10;
use Acme::Tools qw(srlz);
use List::Util qw(sum);

sub ty{
    my $h=shift;
    my %c;$c{$_}++ for split//,$h;
    my $fr=join'',reverse sort values %c;
#    die"fr=$fr   $h ".srlz(\%c,'c');
    $fr eq '5' ? 7 #five of a kind
	:$fr eq '41' ? 6
	:$fr eq '32' ? 5
	:$fr eq '311' ? 4
	:$fr eq '221' ? 3
	:$fr eq '2111' ? 2
	:                1;
    {5=>7, 41=>6, 32=>5, 311=>4, 221=>3, 2111=>2, 11111=>1}->{$fr} || die
}

my %st;@st{qw(A K Q J T 9 8 7 6 5 4 3 2)}=reverse(2..14); #die srlz(\%st,'st');
my @l=
map{
    my($hand,$bid)=/\w+/g;
    my$type=ty($hand);
    my@sts=map 1e3+$st{$_},split//,$hand;
    my$o="$type ".join(' ',@sts);
    die"hand=$hand @sts $o\n" if length($o)!=26;
    die if $seen{$hand}++;
    {hand=>$hand,type=>$type,bid=>$bid,o=>$o}
}
<>;

my $rank=0;
@l=map{$$_{rank}=++$rank;$_}sort{$$a{o}cmp$$b{o}}@l;

say srlz(\@l,'l','',1);
#say join' + ', map{"$$_{rank}*$$_{bid}"}@l;
say eval join' + ', map{"$$_{rank}*$$_{bid}"}@l;
say sum map{$$_{rank}*$$_{bid}}@l;


__DATA__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483

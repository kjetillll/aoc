use v5.10;
use Acme::Tools qw(srlz);
use List::Util qw(sum max);
#my@lab=qw(A K Q J T 9 8 7 6 5 4 3 2);
my@lab=qw(A K Q   T 9 8 7 6 5 4 3 2 J);
my %st;@st{@lab}=reverse(2..14); #die srlz(\%st,'st');

sub ty{
    my $h=shift;
    my %c;$c{$_}++ for split//,$h;
    my $fr=join'',reverse sort values %c;
#    die"fr=$fr   $h ".srlz(\%c,'c');
    {5=>7, 41=>6, 32=>5, 311=>4, 221=>3, 2111=>2, 11111=>1}->{$fr} || die
}

sub tyj{
    my $h=shift;
    return 7 if $h eq 'JJJJJ';
    my$aj=$h=~s/J/J/g;
#    if($aj>1){
	my$g=join',',@lab;
	$g=$h=~s/J/{$g}/gr;
	@g=glob("$g");
#    }
    #    max(map ty($h=~s/J/$_/gr),@lab);
    my$ty=max(map ty($_),@g);
#    die "h: $h  $ty ".ty($h) if $h=~/J.*J/ and $ty>ty($h);
#    die "h: $h  $ty ".ty($h) if @g==169;
#    die"h=$h  aj=$aj   $g\n@g\nantg: ".@g."\nty=$ty\n" if @g>2197;
    $ty;
}

my @l=
map{
    my($hand,$bid)=/\w+/g;
    my$type=tyj($hand);
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

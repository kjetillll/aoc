# https://adventofcode.com/2023/day/5 - del 2
# kjør:
#
#   perl 2023_day_05.pl 2023_day_05_ex.txt     # svar: 35                etter 0.006 sek
#
# Dette er en stygg brute force, bedre metode finnes helt sikkert.
#
# Den ekte inputen er såpass stor at kjøretiden blir ca 5 timer hvis man bare kjører slik:
#
#   perl 2023_day_05_part_2.pl 2023_day_05_input.txt
#
# man bør i steden kjøre det slik i bash fra kommandolinjen i feks 10 (eller 20?) parallelle jobber:
#
# for jobb in {0..4}; do ( time perl 2023_day_05_part_2.pl 2023_day_05_input.txt $jobb | tee /tmp/d5j$jobb & ); done
# for jobb in {5..9}; do ( time perl 2023_day_05_part_2.pl 2023_day_05_input.txt $jobb | tee /tmp/d5j$jobb & ); done
#
# Når de er ferdige:
#
# grep 'svar: ' /tmp/d5j*        #svaret er da det minste tallet av disse

# Trolig bedre idé, ikke gjort:
# i stedet for å prøve alle $x, og kun øke den med 1, finn hvor mye man kan øke $x ved å finne grensene og registrere "segmentene", også de tomme

$|=1;
use v5.10;
use List::Util qw(min sum);
use Acme::Tools qw(srlz);

my @s;
while(<>){
    if(/^seeds:/){
	push@s,[$1,$1+$2-1] while s/(\d+)\s+(\d+)//;
	@s = @s[shift] if @ARGV; #jobbnr
	say srlz(\@s,'s');
    }
    elsif( /:/  ){ push @ll, []              }
    elsif( /\d/ ){ push @{$ll[-1]}, [/\d+/g] }
}
my $min = 99e99;
my $a = sum map { $$_[1] - $$_[0]+1 } @s;
say"antall: $a";
my $i = $a;
for(@s){
    my($fr,$to) = @$_;
    die if @$_ != 2;
    my$x = $fr;
    while($x <= $to){
	my $n = $x;
	for(@ll){
	    my @l = @$_;
	    my $m;
	    my $il=0;
	    for(@l){
		my($d,$s,$c) = @$_;
		$m = $_ and last if $n>=$s && $n<$s+$c;
		$il++;
	    }
	    unshift @$_, splice @$_, $il, 1 if $il;
	    $n += $$m[0] - $$m[1] if $m;
	}
	$min = $n if $n < $min;
	printf "gjenstår: $i   min nå: $min   ".int(($a-$i)/(time()-$^T+1e-6))." pr sek \r" if --$i%5e4==0;
	$x++;
    }
}
say;
say "svar: $min";

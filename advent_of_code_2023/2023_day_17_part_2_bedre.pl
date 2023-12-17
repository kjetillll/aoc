# https://adventofcode.com/2023/day/17
# perl 2023_day_17_part_2_bedre.pl 2023_day_17_ex.txt     # => 94  eksempel 1
# perl 2023_day_17_part_2_bedre.pl 2023_day_17_ex2.txt    # => 71  eksempel 2
# perl 2023_day_17_part_2_bedre.pl 2023_day_17_input.txt  # => 773 etter runde 38-50 og ~10 minutter 17 sek
#
# Om resultatet:
# Nådde "svar så langt: 773" som stabiliserte seg i runde 38 og "ant: 6407651"
# uten nubbesjans-beskrankningen) eller "ant: 2421973" med,
# økte ikke etter runde 47. Stoppkriterium er tre runder
# uten at "ant: x" har økt.

# Brute force! Det finnes det nok en mindre brutal metode med smartere
# DP (dynamic programming) og caching og rekursjon.

# Hovedidèen: i hver celle, smitt minimumsresultatet fra nabocellene +
# siffer i  egen celle  for hvert registrerte  steg til  naboene pluss
# motsatt retning fra curr celle, ta  vare på stegene men trenger ikke
# mer enn de ti siste, hold rede på min() for hvert stegmønster i hver
# celle, svar til slutt er min for mønsterne i siste celle nederst til
# høyre som er svaret.

# Speedup:
# Reduserte kjøretiden etter å ha lagt inn "nubbesjans"-beskrankningen (søk: nubbesjans)
# der man for hver celle finner minimum avstand til mål uten reglene som beskranker
# hvordan man tar steg. Hvis et mellomresultat er så høyt at man ikke har nubbesjans
# til å nå mål iht hva som er beste resultat så langt, så prøver den ikke.
# Her fjernes mellomresultater underveis etterhvert som man finner nye
# beste-så-langt. Speedup-en reduserte 18min --> 9m 45s.

use List::Util qw(sum min max); use strict; use warnings; no warnings 'recursion'; use v5.10;
$|=1;
my $kart = join'',<>;                    #input hele filen som en streng
my $vidde = $kart=~/.+/?1+length$&:die;  #bredde inkl \n
my $hoeyde = 0+grep$_,split/\n/,$kart;   #antall linjer
my%r;@r{qw(H V O N)} = (1,-1,-$vidde,$vidde); #høyre, venstre, opp, ned

my @pos=grep substr($kart,$_,1)=~/^[1-9]$/, 0..length($kart)-1;
my @avstand;$avstand[$_]=do{my($x,$y)=($_%$vidde,int($_/$vidde));($vidde-2-$x) + ($hoeyde-1-$y)} for @pos;
my $siste=$pos[-1];
my %er_pos; @er_pos{@pos}=();

my @min_avstand=finn_min_avstander();

say"Vidde: $vidde   hoeyde: $hoeyde   ant pos: ".@pos."   siste pos: $pos[-1]";# exit;

my %sum=(0=>{""=>0});
my($runde,@ant)=(0);
my $best_saa_langt=9e9;
sub minpos { my $pos=shift; my @v=values%{$sum{$pos}}; @v?min(@v):-1 }
while(1){
    $runde++;
    for my $pos (@pos){
	next if $pos==0;
	my $pos_siffer=substr($kart,$pos,1);
	my $er_siste=$pos==$siste;
	my $sumpos=$sum{$pos};
	my $avstand_pos=$avstand[$pos];
	my $min_avstand_pos=$min_avstand[$pos];
	for my $r (qw(H V O N)){
	    my $p=$pos+$r{$r};
	    my $sump=$sum{$p};
	    next if !exists$er_pos{$p};
	    my $omvendt = $r=~y/HVON/VHNO/r;
	    my @ikke_nubbesjans;
	    for(keys %{$sum{$p}}){
		my $steg=$_.$omvendt;
		next if $steg=~/(?:HV|VH|ON|NO)$/;                #ikke rygge
		next if $_ and substr($steg,-1,1) ne substr($steg,-2,1) and $steg=~/(.)\1*.$/ and length($&)<5; #ikke sving før minst 4
#		next if $steg=~/(?:(.)\1*)(.)$/ and $2 ne $1 and length($&)<5; #ikke sving før minst 4
		#next if $steg=~/((.)\2*)(.)$/ and $2 ne $3 and length($1)<4;
		#next if $steg=~/(H+[VON]|V+[HON]|O+[HVN]|N+[HVO])$/ and length($1)<5; #tregere
	        #next if $steg=~/(.)\1\1\1\1\1\1\1\1\1\1$/;       #kan ikke 11 på rad
		next if $steg=~/(?:H{11}|V{11}|O{11}|N{11})$/;    #kan ikke 11 på rad
		next if $er_siste and $steg !~ /(.)\1\1\1$/;      #må ende på minst fire på rad i samme retning
		#next if $steg=~/(.)\1\1\1$/;     #part 1: kan ikke fire på rad
		$steg=substr($steg,-10) if length($steg)>10; #hm
		my $her=$pos_siffer+$$sump{$_};
#		next if $her+$avstand_pos > $best_saa_langt; #ikke nubbesjans å nå fram
		next if $her+$min_avstand_pos > $best_saa_langt+4 and push@ikke_nubbesjans,$_; #hm+4
		$$sumpos{$steg} = $her if !exists$$sumpos{$steg} || $her < $$sumpos{$steg};
	    }
	    delete@{$sum{$p}}{@ikke_nubbesjans};
	}
    }
    my $ant=sum map 0+keys%{$sum{$_}}, @pos;
    #    print !exists$er_pos{$_}?"\n":sprintf("%3d ",minpos($_)) for 0..$pos[-1];print"\n";
    my($mi,$ss)=(int((time()-$^T)/60),(time()-$^T)%60);
    $best_saa_langt=minpos($pos[-1]) if minpos($pos[-1])>0;
    print"runde: $runde   ant: $ant   siste pos: $pos[-1]   tid: ${mi}m ${ss}s   svar så langt: ".minpos($pos[-1])."\n";
    push @ant, $ant;
    last if @ant>20 and $ant[-2]==$ant[-1] and $ant[-3]==$ant[-1] and $ant[-4]==$ant[-1];
    #TODO: bør få bedre stoppkriterium? bruker her bare: hvis samme $ant i x siste runder
}
say "svar: ".minpos($pos[-1]);

sub finn_min_avstander {
    my @ma;
    my $runde=0;
    $ma[$siste]=0;
    say"siste: $siste";
    my @r=@r{qw(H V O N)};
    my @ma_forrige=();
    while(1){
	my $rundeendringer=0;
	$runde++; #say"ma runde: $runde";	
	print "finn_min_avstander() runder: $runde\r";
	for my $pos (@pos){
	    my $siffer=substr($kart,$pos,1);
	    my @ser=grep defined$ma[$_],grep 0<=$_&&$_<length($kart),map{$pos+$_}@r;
	    for(@ser){
		if( !defined$ma[$pos] || $siffer+$ma[$_] < $ma[$pos] ){
		    $ma[$pos]=$siffer+$ma[$_];
		    $rundeendringer++;
		}
	    }
	}
	last if $rundeendringer==0;
    }
    #print substr($kart,$_,1) eq "\n" ? "\n" : sprintf"%3d ",defined$ma[$_]?$ma[$_]:-1 for 0..length($kart)-1;
    print"\n";
    #exit;
    @ma;
}

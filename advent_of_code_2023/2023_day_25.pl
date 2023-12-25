# https://adventofcode.com/2023/day/25
# perl 2023_day_25.pl 2023_day_25_ex.txt    # => 54 (noen ganger 56, se under), 0.12 sek
# perl 2023_day_25.pl 2023_day_25_input.txt # => 600369   15 sek

# ---- Idé for part 1 ----
#
# Gjenta 30 ganger:
#   finn korteste path mellom to random noder
#   gå den pathen og tell antall ganger en edge passeres
#   kutt edgen (broen) som er passert hyppigst, gjenta alt tre ganger for å finne og kutte de tre broene
# Til slutt: finn de to ikke-sammenkoblede subgrafene og multipliser størrelsen på de, dette er svaret.
#
# Randomheten her kan gi galt svar eller at grafen fortsatt er sammenkoblet etter at tre broer er kuttet,
# men tester viser at man så å si alltid får samme riktige svar både med eksempel-inputen og den ekte inputen.
# Øk tallet 30 for å øke sannsynligheten for riktig svar. Man får stort sett riktig ved å redusere 30 til 20 også.
#
# Eksempel-inputen skal i følge oppgaven gi svaret 54.
# Men det finnes tre andre riktige kuttinger som gir svar 56. Forvirrende! dette er: frs/qnr jqt/nvd nvd/pz

my $gjenta = 30;                                #hm, 30 forsøk, hva er nok???

use strict; use warnings; use v5.10;
use Graph;

#---------- les og registrer input
my $g = Graph->new( undirected => 1 );
while(<>){
    my($fra,@til)=/\w+/g;
    $g->add_edge($fra, $_) for @til;
}
say "edges: ".$g->edges;

#---------- finn de tre riktige broene å kutte
my @cc;                                         #subgrafer (connected components), kun en subgraf inntil riktige 3 broer kuttet
my @kuttet;                                     #info om kuttede broer
while( @cc != 2 ){                              #inntil man sitter med to subgrafer, prøv igjen! sjelden nødv med flere forsøk
    @kuttet=();
    for my $bro (1..3){                         #finn og kutt bro nr 1, 2 og 3
	my %pass;                               #tell passeringer
	my %gjort;                              #ikke bruk samme nodepar flere ganger
	my @n = $g->vertices;                   #nodene
	my $info=sub{$|=1;printf"sletting av bro nr $bro   edge-passeringer: %d   forsøk nr: %d%s",0+keys%pass,@_};
	for(1..$gjenta){                        
	    my($n1, $n2) = sort map{ $n[rand@n] } 1, 2;         #velg to random noder
	    &$info($_,"\r");
	    next if $n1 eq $n2 or $gjort{$n1,$n2}++;            #hindre samme node og at samme par er gjort før
	    my @sp = $g->SP_Dijkstra($n1, $n2);                 #shortest path
	    my @e = map {join'/',sort@sp[$_,$_+1]} 0 .. $#sp-1; #finn edges
	    $pass{ $_ }++ for @e;                               #øk antall pass på hver edge (hver potensielle bro)
	}
	&$info($gjenta,"\n");
	
	my @pass = sort{ $pass{$b} <=> $pass{$a} || $a cmp $b } keys %pass;
	say "    antall passeringer over edge $_: $pass{$_}" for @pass[0..3]; #viser de fire hyppigste
	my($n1,$n2)=split '/', $pass[0];         #oftest passerte edge i denne runden
	$g->delete_edge($n1, $n2);               #fjerner den edgen, dvs kutter bro nr $nr
	push @kuttet, "$n1/$n2";
	@cc = $g->connected_components;          #finner de sammenhengende subgrafene, kun 1 før de tre riktige broene er kuttet
	say "    kuttet $n1 <-> $n2   antall subgrafer nå: ".@cc;
    }
    $g->add_edge(split'/') for @kuttet;          #legg tilbake de kuttede i tilfelle ny while-runde nødv
}

#---------- svar
@cc = map 0+@$_, @cc;                            #kun interessert antall noder i subgrafene, ikke innholdet
say "subgrafenes størrelser: @cc";
say "svar: $cc[0] * $cc[1] = ", $cc[0] * $cc[1], "            kuttet: ".join' ',sort(@kuttet);

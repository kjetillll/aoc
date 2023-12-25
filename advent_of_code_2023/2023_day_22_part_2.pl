# https://adventofcode.com/2023/day/22
# 2023_day_22_part_2.pl løser både del 1 og 2
#
# perl 2023_day_22_part_2.pl 2023_day_22_ex.txt        # => 7       etter 0.07 sek
# perl 2023_day_22_part_2.pl -v1 2023_day_22_input.txt # => 80778   etter 5.48 sek

$|=1;
use List::Util qw(uniq); use strict; use warnings; use v5.10;
use Getopt::Std; my %opt; getopts('v:',\%opt);
$opt{v} //= 1; # -v x   der x er verbosity (pratsomhetsnivå), default 1

my @linje = map s/\n//r,<>;
my @navn = @linje<=26 ? ('A'..'Z') : ('AAA'..'ZZZ');
my @brikke = map{[shift@navn,/\d+/g]}@linje;
my %ok; #okkupert, key=>val er x,y,z => navn
my $ant_fall;
for(@brikke){
    my($navn,$x1,$y1,$z1,$x2,$y2,$z2)=@$_;
    my $r=0;
    map $ok{$_,$y1,$z1}=$navn, $x1..$x2 if $x1!=$x2 and ++$r;
    map $ok{$x1,$_,$z1}=$navn, $y1..$y2 if $y1!=$y2 and ++$r;
    map $ok{$x1,$y1,$_}=$navn, $z1..$z2 if $z1!=$z2 || !$r and ++$r; # ...or 1x1x1
    die if $x1>$x2 or $y1>$y2 or $z1>$z2 or $r>1; #jic, ingen
}
my %brikke; push @{ $brikke{ $ok{$_} }{celler} }, $_ for keys%ok; #sort?
say "ant ok: ".keys(%ok)."   l: ".@linje."  c: ".@brikke."   navn: ".(26**3-@navn)
   ."   ant brikke: ".keys(%brikke)."   uniq ok val: ".uniq(values%ok);

my $fallrunde=0;
sub under {
    my $navn=shift;
    sort uniq grep defined, map {
	my($x,$y,$z)=split$;,$_;
	$ok{$x,$y,$z-1} && $ok{$x,$y,$z-1} ne $navn ? $ok{$x,$y,$z-1} : $z==1 ? 'GULV' : undef
    }
    @{ $brikke{$navn}{celler} };
}

while(1){                                        # kjør runder inntil ingen flere har falt
    $fallrunde++;
    my $ingen_har_falt = 1;                      # true inntil motsatt bevist
    for my $navn ( keys %brikke){
	my $c = $brikke{$navn}{celler};          # brikkens celler i @$c
	my @under = under($navn);
	if(not @under) {                         # ingen under denne brikken, ikke GULV heller => kan falle
	    my @c_ny = map s/\d+$/$&-1/er, @$c;  # fall ett hakk, z-=1
	    @ok{@c_ny} = delete @ok{@$c};        # $navn okkuperer nå disse i stedet, delete returnerer slettedes values
	    $brikke{$navn}{celler} = \@c_ny;     # oppdater med celler ett hakk ned
	    $ingen_har_falt = 0;                 # false
	    print "ant_fall: @{[++$ant_fall]}  \r" if$opt{v}>=1;
	}
    }
    last if $ingen_har_falt;                     # avbryt while-runder når ingen falt i denne runden
}

$brikke{$_}{under}=[under($_)] for keys %brikke;
for my $navn (keys %brikke){
    $brikke{$navn}{over}//=[];
    for my $navn_under ( grep {not /GULV/} @{$brikke{$navn}{under}} ){
	push @{$brikke{$navn_under}{over}}, $navn;
    }
}

for my $navn (keys %brikke){
    my $alle_over_har_annen_under = 1;  #true inntil motsatt bevist
    for my $over ( @{$brikke{$navn}{over}} ) {
	my $har_annen_under = grep{$_ ne $navn and $_ ne 'GULV'} @{$brikke{$over}{under}};
	$alle_over_har_annen_under = 0 if !$har_annen_under;
    }
    $brikke{$navn}{kan_fjernes}=$alle_over_har_annen_under?1:0;
}

my @gulv = grep{ @{$brikke{$_}{under}} && $brikke{$_}{under}[0] eq 'GULV' }sort keys%brikke;

#print srlz(\%brikke,'brikke','',1)=~s/$;/,/gr if $opt{v}>=2;

say "fallrunder: $fallrunde" if $opt{v}>=1;
say "gulv: ".join',',@gulv if $opt{v}>=1;
say "Kan fjernes: ".join' ',grep{$brikke{$_}{kan_fjernes}}keys%brikke if $opt{v}>=2;
say "ant_fall: $ant_fall";
say "svar del 1: " . grep{$brikke{$_}{kan_fjernes}}keys%brikke;

#------------------- del 2
my $sum_faller=0;
for my $navn (sort keys %brikke){
    my %fjernet = ($navn=>1);
    my @g = @{ $brikke{$navn}{over} };  # @g = gjenstår å sjekke
    while( my $navn = shift @g ){
	my $ingen_under = ! grep !$fjernet{$_}, @{ $brikke{$navn}{under} }; #ingen under som ikke er fjernet
	++$fjernet{$navn} and push @g, @{ $brikke{$navn}{over} } and @g=uniq@g if $ingen_under;
    }
    my $antall_andre_faller = keys(%fjernet) - 1;
    say"ødeleggelse av $navn vil få $antall_andre_faller andre brikker til å falle" #: ".join(' ',sort grep!/$navn/, keys %fjernet)
	if $opt{v}>=2 and $antall_andre_faller>0;
    $sum_faller += $antall_andre_faller;
}
say "svar del 2: $sum_faller";

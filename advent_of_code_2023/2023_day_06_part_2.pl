# https://adventofcode.com/2023/day/6 - del 2
# kjør:
#
# perl 2023_day_06_part_2.pl 2023_day_06_ex.txt     # svar: 71503      etter 0.017 sek
# perl 2023_day_06_part_2.pl 2023_day_06_input.txt  # svar: 38017587   etter ca 9 sek
#
# Idé for raskere kjøretid / mer elegant:
# kunne trolig være gjort med andregradsligning og differanse mellom de to løsningene
# s*(t-s)=d
# -s² + ts - d = 0
# og kanskje -1..1 rundt løsningene for å ta hånd om +1 -1 problematikken

use v5.10;
my @t = <> =~ /\d+/g;
my @d = <> =~ /\d+/g;

my $part = shift // 2;  #1 eller 2 der 2 er default
if($part == 2){
    @t = (join'',@t);
    @d = (join'',@d);
}

for my $t ( @t ){
    say "t: $t";
    my @way;
    my $d = shift@d;
    for my $s ( 1 .. $d ){
	my $w = $s * ( $t - $s );
	push @way, $w if $w > $d;
	last if $w < 0;
	print "1..$d   w: $w   way: ".@way."   $s\r" if $s % 1e3 == 0;
    }
    print"\n";
    #say "@way\n";
    push @ws, 0+@way;
}
say "ways: @ws";
say "svar: ", eval join '*', @ws;

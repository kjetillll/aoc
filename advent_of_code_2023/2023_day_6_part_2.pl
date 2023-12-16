use v5.10;
my@t=<>=~/\d+/g;
my@d=<>=~/\d+/g;
my $part=shift()//2;
if($part==2){
    @t=(join'',@t); @d=(join'',@d);
}

for$t(@t){
    say"t: $t";
    my@way;
    my$d=shift@d;
    for$s(1..$d){
	my$w=$s*($t-$s);
	push@way,$w if $w>$d;
	last if $w<0;
	print"1..$d   w: $w   way: ".@way."   $s\r" if $s%1e3==0;
    }
    print"\n";
    #say "@way\n";
    push@ws,0+@way;
}
say"ways: @ws";
say eval join'*',@ws;
__END__

solution part 1: ways: 36 58 57 37   =>  4403592

solution part 2: 38017587       med kjøretid: 18s


for raskere kjøretid / mer elegant:

kunne trolig være gjort med andregradsligning og differanse mellom de to løsningene

s*(t-s)=d
-s² + ts - d = 0

og kanskje -1..1 rundt løsningene for å ta hånd om +1 -1 problematikken


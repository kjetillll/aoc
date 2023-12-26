# https://adventofcode.com/2023/day/12 - del 1
# kjør:
#
# perl 2023_day_12.pl 2023_day_12_ex.txt      # svar: 21
# perl 2023_day_12.pl 2023_day_12_input.txt   # svar: 7460         0.87 sek

use strict; use warnings; use List::Util 'sum';
my $pratsom = 0;
my $arr = 0;
while( <> ){
    my($p, $d) = /\S+/g; #pattern dammaged-groups
    $p =~ s/\./_/g;
    my $pr = $p =~ s/\?/./gr;
    $pr = qr/^$pr$/;
    my @d = $d=~/\d+/g;
    my $sumd = sum(@d);
    my $sums = length($p) - $sumd;
    my @c = map [1 .. $sums], 1 .. @d-1;
    unshift @c, [0 .. $sums];
    push    @c, [0 .. $sums];
    my $arrlinje = 0;
    my $filter      = sub{sum(@$_)<=$sums};
    my $filterslutt = sub{sum(@$_)==$sums};
    @c = map { ( $_, $filter ) } @c;
    $c[-1] = $filterslutt;
    for my $c ( cart( @c ) ){
        my $s = join '', map { "_" x $$c[$_] . "#" x ($d[$_]//0) } 0 .. @$c-1;
        $arrlinje++ if $s =~ $pr;
    }
    $arr += $arrlinje;
    print "linje: $.   p: $p   d: @d   arrlinje: $arrlinje   sum: $arr\n" if $pratsom;
}
print "svar: $arr\n";


sub cart { #kartesisk produkt
    my @ars = @_;
    if( not ref $_[0] ){ #if hash-mode detected
	my(@k, @v); push @k, shift @ars and push @v, shift @ars while @ars;
	return map { my %h; @h{@k} = @$_; \%h } cart(@v);
    }
    my @res = map [$_], @{ shift@ars };
    for my $ar ( @ars ){
	@res = grep { &$ar(@$_) } @res and next if ref($ar) eq 'CODE';
	@res = map { my $r = $_; map { [ @$r, $_ ] } @$ar } @res;
    }
    @res;
}

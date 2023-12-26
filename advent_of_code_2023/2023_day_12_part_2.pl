# https://adventofcode.com/2023/day/12 - del 2
# kjør:
#
# perl 2023_day_12_part_2.pl 2023_day_12_ex.txt      # svar: 525152                0.01 sek
# perl 2023_day_12_part_2.pl 2023_day_12_input.txt   # svar: 6720660274964         1.54 sek

use strict; use warnings; no warnings 'recursion';

my $pratsom = 0;
my $part = "@ARGV" =~ /^-p ([12])/ && splice(@ARGV,0,2) ? $1 : 2;
my($sum, $arr, %cache);

while(<>){
    my($p,$d) = /\S+/g; #pattern, dammaged-groups
    $p = join '?', ($p) x ( $part == 2 ? 5 : 1 );
    $d = join ',', ($d) x ( $part == 2 ? 5 : 1 );
    my @d = $d =~ /\d+/g;
    my $arr = arr( $p, @d );
    $sum += $arr;
    printf "L%-4d sum: %13d   arr: %10d   cache: %-5d   p: $p   d: @d\n", $., $sum, $arr, 0+keys(%cache) if $pratsom;
}    

print "svar: $sum\n";

sub arr {                                               #retur: antall arrangementer
    $cache{"@_"} //= do {                               #memoize/cache og gjenbruk resultatet
	my($p,@d) = @_;                                 #pattern, dammaged group sizes
	my $re = $cache{ $d[0] // 0 } //=
	    @d ? qr/^[#?]{$d[0]}([^#]|$)/ : qr/^nei/;
        $p =~ s/^\?//  ? arr(".$p",@d) + arr("#$p",@d)  #? kan være både . og #
       :$p =~ s/^\.+// ? arr($p,@d)
       :$p =~ s/$re//  ? arr($p,@d[1..$#d])
       :                 !($p||@d)
   }
}

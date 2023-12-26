# perl 2023_day_12_part_2.pl -p 1 2023_day_12_ex.txt    # -p 1    => 21
# perl 2023_day_12_part_2.pl -p 2 2023_day_12_ex.txt    # -p 2    => 525152
# perl 2023_day_12_part_2.pl -p 1 2023_day_12_input.txt # part 1  => 7460             0.75 sek uten memoize
# perl 2023_day_12_part_2.pl -p 1 2023_day_12_input.txt # part 1  => 7460             0.12 sek med memoize
# perl 2023_day_12_part_2.pl -p 2 2023_day_12_input.txt # part 2  =>                  uendelig tid uten memoize
# perl 2023_day_12_part_2.pl -p 2 2023_day_12_input.txt # part 2  => 6720660274964    3.1 sek med memoize

use strict; use warnings; no warnings 'recursion';
my $part = "@ARGV" =~ /^-p ([12])/ && splice(@ARGV,0,2) ? $1 : 2;
my($sum, $arr, %cache);

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

while(<>){
    my($p,$d) = /\S+/g; #pattern, dammaged-groups
    $p = join'?', ($p) x ($part==2 ? 5 : 1);
    $d = join',', ($d) x ($part==2 ? 5 : 1);
    my @d = $d=~/\d+/g;
    my $arr = arr($p,@d);
    $sum += $arr;
    printf "L%-4d sum: %13d   arr: %10d   cache: %-5d   p: $p   d: @d\n", $., $sum, $arr, 0+keys(%cache);
}    
print "svar: $sum\n";

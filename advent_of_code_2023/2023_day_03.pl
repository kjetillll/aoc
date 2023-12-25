# https://adventofcode.com/2023/day/3 - del 1
# perl 2023_day_3.pl 2023_day_3_ex.txt     # svar: 4361          0.007 sek
# perl 2023_day_3.pl 2023_day_3_input.txt  # svar: 532331        0.02 sek

$s=$_=join'',<>;
my$w=1+length((/.*/g)[0]); 1+length!=$w and die for split/\n/;
my%s;
s{[^\d\.\n]}{$s{pos()}++;$&}ge;
my$sum;
s{\d+}{
    my$p=pos();
    my%c;@c{ $_+$p-$w-1,  $_+$p-$w,  $_+$p-$w+1,
             $_+$p-1,     $_+$p,     $_+$p+1,
             $_+$p+$w-1,  $_+$p+$w,  $_+$p+$w+1
           }=() for 0..length($&)-1;
    $sum+=$& if grep$_,@s{keys%c};
}ge;
print "svar: $sum\n";

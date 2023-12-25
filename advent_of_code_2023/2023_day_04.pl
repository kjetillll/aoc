# https://adventofcode.com/2023/day/4 - del 1
#
# kjør enten:
#
#   perl -nE'($w,$c)=(map[/\d+/g],split/\:|\x7c/)[1,2];say $s+=int(2**(-1+grep{$_~~@$w}@$c))' 2023_day_04_ex.txt    |tail -1  #13
#   perl -nE'($w,$c)=(map[/\d+/g],split/\:|\x7c/)[1,2];say $s+=int(2**(-1+grep{$_~~@$w}@$c))' 2023_day_04_input.txt |tail -1  #33950
#
# eller:
#
#   perl 2023_day_04.pl 2023_day_04_ex.txt     # svar: 13             etter 0.006 sek
#   perl 2023_day_04.pl 2023_day_04_input.txt  # svar: 33950          etter 0.016 sek

use experimental 'smartmatch';

while(<>){
    ($w,$c)=(map[/\d+/g],split/\:|\x7c/)[1,2];
    $s+=int(2**(-1+grep{$_~~@$w}@$c))
}
print "svar: $s\n";

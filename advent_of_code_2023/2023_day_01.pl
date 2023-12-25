#https://adventofcode.com/2023/day/1
#
#kjør enten:
#
#  perl -nE'@d=/\d/g;$s+=$d[0].$d[-1];eof&&say$s' 2023_day_01_ex.txt      #eksempeldataene i oppgaven
#  perl -nE'@d=/\d/g;$s+=$d[0].$d[-1];eof&&say$s' 2023_day_01_input.txt
#
#eller
#
# perl 2023_day_01.pl 2023_day_01_ex.txt
# perl 2023_day_01.pl 2023_day_01_input.txt

while(<>){                 #where flere linjer å lese
    @d = /\d/g;            #finn sifrene (digits 0-9) i linjen
    $s += $d[0].$d[-1];    #legg til første siffer * 10 + siste siffer
}
print "svar: $s\n";

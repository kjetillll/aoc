#kjør enten:
#
#  perl -nE'@h{1..9}=@h{qw(one two three four five six seven eight nine)}=1..9;$r=join"|",keys%h;/$r/;$s+=$h{$&}.0;/.*($r)/;say$s+=$h{$1}' 2023_day_01_input.txt
#
#eller
#
# perl 2023_day_01_part_2.pl 2023_day_01_input.txt

@h{1..9}=@h{qw(one two three four five six seven eight nine)}=1..9;
$r=join"|",keys%h;
while(<>){
    /$r/;
    $s += $h{$&}.0;
    /.*($r)/;
    $s+=$h{$1}
}
print "svar: $s\n";

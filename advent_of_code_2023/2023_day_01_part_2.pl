perl -nE'@h{1..9}=@h{qw(one two three four five six seven eight nine)}=1..9;$r=join"|",keys%h;/$r/;$s+=$h{$&}.0;/.*($r)/;say$s+=$h{$1}' 2023_day_1_input.txt

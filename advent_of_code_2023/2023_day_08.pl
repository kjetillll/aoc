# https://adventofcode.com/2023/day/8 - del 1
# kjør:
#
# perl 2023_day_08.pl 2023_day_08_ex.txt     # svar: 2 steps              0.007 sek
# perl 2023_day_08.pl 2023_day_08_input.txt  # svar: 20777 steps          0.017 sek

my @i = split //, <> =~ /\w+/ ? $& : die;

while(<>){
    my($n, $l, $r) = /(\w+)/g;
    $n{$n} = { L=>$l, R=>$r };
}

my($now, $steps) = ('AAA', 0);

$now = $n{$now}{ $i[ $steps++ % @i ] } while $now ne 'ZZZ';

print "svar: $steps steps\n";

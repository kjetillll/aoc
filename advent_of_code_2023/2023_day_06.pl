# https://adventofcode.com/2023/day/6 - del 1
# perl 2023_day_06.pl 2023_day_06_ex.txt     # svar: 288              etter 0.002 sek
# perl 2023_day_06.pl 2023_day_06_input.txt  # svar: 4403592          etter 0.003 sek

use v5.10;
@t = <>=~/\d+/g;
@d = <>=~/\d+/g;
for $t ( @t ){
    say "t: $t";
    my@way;
    my$d=shift@d;
    push @way, $_ * ($t-$_) for 1..$d;
    @way = grep {$_>$d} @way;
    say "@way\n";
    push @ws, 0+@way;
}
say "ways: @ws";
say "svar: ", eval join '*', @ws;

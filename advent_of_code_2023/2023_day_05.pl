# https://adventofcode.com/2023/day/5 - del 1
# kjør:
#
#   perl 2023_day_05.pl 2023_day_05_ex.txt     # svar: 35                etter 0.006 sek
#   perl 2023_day_05.pl 2023_day_05_input.txt  # svar: 227653707         etter 0.01 sek

use v5.10;
use List::Util 'min';

my @s = <> =~ /\d+/g;

while(<>){
    if(    /:/  ){ push @ll, []              }
    elsif( /\d/ ){ push @{$ll[-1]}, [/\d+/g] }
}
say "svar: ", min map {
    my $n = $_;
    for( @ll ){
        my @l = @$_;
        my $m = (
            grep{
                my($d,$s,$c)=@$_;
                $n>=$s && $n<$s+$c
            }
            @l
        ) [0];
        $n += $$m[0] - $$m[1] if $m;
    }
    $n
}
@s;

# https://adventofcode.com/2023/day/3 - del 2
# perl 2023_day_03_part_2.pl 2023_day_03_ex.txt     # svar: 467835          0.007 sek
# perl 2023_day_03_part_2.pl 2023_day_03_input.txt  # svar: 82301120        0.02 sek

use List::Util 'sum'; use v5.10;
$s=join'',<>;
$s=~/.+/;
$w=1+length$&;
@c=(-$w-1,-$w,-$w+1,-1,1,$w-1,$w,$w+1);
$s=~s{\d+}{$n{$_}{$&}++ for grep substr($s,$_,1)eq'*',grep$_>=0,map$_+pos$s,map{$c=$_;map$c+$_-1,@c}1..length$&}ge;
say "svar: ", sum map { @k=keys%{$n{$_}}; @k-2 ? 0 : $k[0]*$k[1] } keys%n;

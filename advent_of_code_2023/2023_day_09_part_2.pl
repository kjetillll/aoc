# https://adventofcode.com/2023/day/9 - del 2
# kjør:
#
# perl 2023_day_09_part_2.pl 2023_day_09_ex.txt     # svar: 2
# perl 2023_day_09_part_2.pl 2023_day_09_input.txt  # svar: 1140               0.008 sek

sub lst { (grep$_,@_) ? ( $_[0] - ( lst( map { $_[$_] - $_[$_-1] } 1 .. $#_ ) )[0], @_ ) : (0, @_) }
printf "svar: %d\n", eval join '+', map { ( lst( /-?\d+/g ) )[0] } <>;

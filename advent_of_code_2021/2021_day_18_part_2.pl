use strict; use warnings; use v5.10; use List::Util 'max';

sub reduced {
    my $s = shift;
    TRY:
    while(1){
        while( $s =~ /\[(\d+),(\d+)\]/g ){
            my($pre, $match, $post, $a, $b) = ($`, $&, $', $1, $2);
            next if ( $pre =~ s/\[/\[/g )
                  - ( $pre =~ s/\]/\]/g ) < 4;  #nesting level = count '[' minus count ']'
            $pre  =~ s/.*\b\K(\d+)/$1+$a/e;
            $post =~ s/(\d+)/$1+$b/e;
            $s = $pre . '0' . $post;
            next TRY;
        }
        $s =~ s{\d\d+}{ "[".int($&/2).",".int($&/2+0.5)."]" }e and next TRY;
        return $s;
    }
}

sub magnitude { my $s = shift; 1 while $s =~ s/\[(\d+),(\d+)\]/ 3 * $1 + 2 * $2 /e; $s }

my @inp = map s/\n//r, <>;

say "Answer: ", max
                map magnitude( reduced( sprintf "[%s,%s]", @inp[ @$_ ] ) ),
                grep $$_[0] != $$_[1], #hm
                map [ int($_ / @inp), $_ % @inp ], 0 .. @inp ** 2 - 1;

# https://adventofcode.com/2021/day/18
# time perl 2021_day_18_part_2.pl 2021_day_18_input.txt   # 2.80 sec
# Answer: 4600

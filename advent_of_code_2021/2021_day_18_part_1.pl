use strict; use warnings; use v5.10;

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

my $sum;
while(<>){
    chomp;
    $sum = defined $sum ? reduced("[$sum,$_]") : $_;
}
say "Sum: $sum";
1 while $sum =~ s/\[(\d+),(\d+)\]/ 3 * $1 + 2 * $2 /e; #magnitude
say "Answer: " . $sum;

# https://adventofcode.com/2021/day/18
# time perl 2021_day_18_part_1.pl 2021_day_18_input.txt   # 0.196 sec
# Answer: 3647

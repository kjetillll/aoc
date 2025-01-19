use strict; use warnings; use v5.10; use List::Util qw(uniq);

my($x1,$x2,$y1,$y2) = <> =~ /[-\d]+/g; #target area

sub fire {
    my($vx, $vy, $x, $y, $h) = (@_, 0, 0, 0);
    while( $x <= $x2 and $y >= $y1 ){
        $h = $y if $y > $h;
        my $is_within = ( $x1 <= $x and $x <= $x2 and
                          $y1 <= $y and $y <= $y2      );
        return join(',',@_) if $is_within;  #hit
        $x += $vx;
        $y += $vy;
        $vy--;
        $vx-- if $vx > 0;
    }
    undef  #miss
}

say "Answer: " . uniq grep defined, map fire( $_ % 200, int($_ / 200 - 250) ), 0 .. 100000;;

# perl 2021_day_17_part_2.pl 2021_day_17_input.txt
# Answer: 2371

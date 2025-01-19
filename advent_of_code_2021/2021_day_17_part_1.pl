use strict; use warnings; use v5.10; use List::Util qw(max);

my($x1,$x2,$y1,$y2) = <> =~ /[-\d]+/g; #target area

sub fire {
    my($vx, $vy) = @_;
    my($x, $y, $h) = (0, 0, 0);
    while( $x <= $x2 and $y >= $y1 ){
        $h = $y if $y > $h;
        my $is_within =
            ($x1 <= $x and $x <= $x2
         and $y1 <= $y and $y <= $y2);
        return $h if $is_within;
        $x += $vx;
        $y += $vy;
        $vy--;
        $vx-- if $vx > 0;
    }
    0
}

say "Answer: ", max map fire( $_%100, int $_/100), 0 .. 50000;

# perl 2021_day_17_part_1.pl 2021_day_17_input.txt
# Answer: 10296

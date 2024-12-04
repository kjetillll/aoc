use v5.10; use List::Util 'sum';

say sum map{
    my($l, $w, $h) = sort { $a <=> $b } split/x/;
    my $bow = $l * $w * $h;
    my $wrap = 2 * $l  +  2 * $w;
    $wrap + $bow
} <>;

#3842356

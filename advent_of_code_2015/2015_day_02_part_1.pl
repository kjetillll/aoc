use v5.10; use List::Util 'sum';

say "Answer: ", sum map{
    my($l, $w, $h) = sort { $a <=> $b } split/x/;
    my $paper = 2*$l*$w + 2*$w*$h + 2*$h*$l;
    my $slack = $l*$w;
    $paper + $slack
} <>;

#Answer: 1606483

use v5.10; use strict; use warnings;

my $i = 0;
say "Answer: ", eval join '*', map { ++$i; $_ eq '[[2]]' || $_ eq '[[6]]' ? $i : 1 } sort { ok_order( eval$b, eval$a ) || -1 } '[[2]]', '[[6]]', grep /\S/, <>;

sub ok_order {
    my($a, $b) = @_;
    return $a < $b ? 1 : $a > $b ? 0 : undef if !ref($a) && !ref($b);
    return ok_order( $a,   [$b] )            if  ref($a) && !ref($b);
    return ok_order( [$a], $b   )            if !ref($a) &&  ref($b);
    my $max_i = $#$a > $#$b ? $#$a : $#$b;
    for my $i ( 0 .. $max_i ){
        my $ok = $i > $#$a ? 1
               : $i > $#$b ? 0
               :             ok_order( $$a[$i], $$b[$i] );
        return $ok if defined $ok;
    }
    undef
}

__END__

time perl 2022_day_13_part_2.pl 2022_day_13_example.txt    # Answer: 140      0.008 sec
time perl 2022_day_13_part_2.pl 2022_day_13_input.txt      # Answer: 22464    0.067 sec

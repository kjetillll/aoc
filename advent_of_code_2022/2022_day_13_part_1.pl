use v5.10; use strict; use warnings;

#my($verbose, $index) = (0, 0);
my($verbose, $index) = (1, 0);

say "Answer: ", eval join '+', map {
    ++$index;
    say "== Pair $index ==" if $verbose;
    $index * ($verbose ? ok_order_verbose(@$_) : ok_order(@$_))
}
map [ eval s/\n/,/r ], split /\n\n/, join'', <>;

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

sub ok_order_verbose {
    my($a, $b, $ind) = (@_, '');  #a=left, b=right, ind=indentation spaces

    my $msg            = sub { say $ind.( @_ ? pop : "- Compare ".dmp($a)." vs ".dmp($b)) };
    my $msg_left       = sub { &$msg('  - Left side is smaller, so inputs ARE in the right order') };
    my $msg_right      = sub { &$msg('  - Right side is smaller, so inputs are NOT in the right order') };
    my $msg_left_miss  = sub { &$msg('  - Left side ran out of items, so inputs ARE in the right order') };
    my $msg_right_miss = sub { &$msg('  - Right side ran out of items, so inputs are NOT in the right order') };
    
    &$msg();
    return $a < $b ? do{ &$msg_left; 1 } : $a > $b ? do{ &$msg_right; 0 } : undef if !ref($a) && !ref($b);
    return ok_order_verbose( $a,   [$b], "$ind  ") if  ref($a) && !ref($b);
    return ok_order_verbose( [$a], $b,   "$ind  ") if !ref($a) &&  ref($b);
    my $max_i = $#$a > $#$b ? $#$a : $#$b;
    for my $i ( 0 .. $max_i ){
        my $ok = $i > $#$a ? do{ &$msg_left_miss;  1 }
               : $i > $#$b ? do{ &$msg_right_miss; 0 }
               :             ok_order_verbose( $$a[$i], $$b[$i], "$ind  " );
        return $ok if defined $ok;
    }
    undef
}

sub dmp { my $x=shift; ref($x) ? "[".join(',',map dmp($_),@$x)."]" : $x }

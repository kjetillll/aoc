use v5.10;
my %timer; $timer{$_}++ for <> =~ /\d+/g;
for ( 1 .. 256 ) {
    my %timer_next;
    for( keys %timer ){
        $timer_next{ $_ == 8 ? 7 : ($_-1) % 7 } += $timer{$_}
    }
    %timer = ( %timer_next, 8 => $timer{0} );
}
say "Answer: " . eval join '+', values %timer;

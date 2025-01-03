use v5.10; use List::Util qw(min max sum);
my @pos = <> =~ /\d+/g;
say "Answer: ",
    min
    map {
        my $try=$_;
        sum map { my $diff = abs( $try - $_ ); $diff * ( $diff + 1 ) / 2 } @pos;
    }
    min(@pos) .. max(@pos);

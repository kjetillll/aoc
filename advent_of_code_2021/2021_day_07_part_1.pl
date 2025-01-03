use v5.10; use List::Util qw(min max sum);
my @pos = <> =~ /\d+/g;
say "Answer: ",
    min
    map {
        my $try = $_;
        sum map abs( $try - $_ ), @pos;
    }
    min(@pos) .. max(@pos);

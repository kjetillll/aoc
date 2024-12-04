use v5.10;
use JSON::XS;
use List::Util 'sum';

sub walk {
    my $s = shift; #struct
    ref($s) eq 'ARRAY' ? sum map walk($_), @$s
   :ref($s) eq 'HASH'  ? grep(/^red$/, values %$s) ? 0 : sum map walk($_) + walk($$s{$_}), keys %$s
   :$s
}

say "Answer: ". walk(decode_json <>);

#Answer: 87842

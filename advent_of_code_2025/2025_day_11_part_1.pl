use strict; use warnings; use v5.10; use List::Util 'sum0';

my %src; #sources of node
for( map [/\w+/g], <>){
    my $dev = shift @$_;
    push @{ $src{$_} }, $dev for @$_
}

my %memoize;
sub paths {
    my($from, $to) = @_;
    $memoize{$from, $to} //= $to eq $from ? 1 : sum0 map paths($from, $_), @{ $src{$to} }
}

say "Answer: ", paths('you' => 'out')


# perl 2025_day_11_part_1.pl 2025_day_11_example.txt
# Answer: 5

# perl 2025_day_11_part_1.pl 2025_day_11_input.txt     # 0.010 seconds
# Answer: 534

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

say "Answer: ",  #one or the other of the next two lines will be 0 since flow from both dac->fft and fft->dac cant exist
                 #since it's a DAG (directed acyclic graph, "can't flow backwards" the challenge said)
    paths('svr' => 'fft') * paths('fft' => 'dac') * paths('dac' => 'out')
 || paths('svr' => 'dac') * paths('dac' => 'fft') * paths('fft' => 'out');


# perl 2025_day_11_part_2.pl 2025_day_11_example_part_2.txt
# Answer: 2

# perl 2025_day_11_part_2.pl 2025_day_11_input.txt     # 0.012 seconds
# Answer: 499645520864100

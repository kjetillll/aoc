use v5.10;
say "Answer: ",  eval join '+', map {
    my($name, $id, $checksum) = /^ (.+) - (\d+) \[ ([a-z]+) \] /x;
    my %freq;
    my @letters = $name =~ /\w/g;
    $freq{$_}++ for @letters;
    my $freq_str = join'', sort {$freq{$b} <=> $freq{$a} || $a cmp $b } keys %freq;
    print "   n: $name   i: $id   c: $checksum   fr: $freq_str\n" if $ENV{VERBOSE};
    substr($freq_str,0,5) eq $checksum ? $id : 0
}<>;

# perl 2016_day_04_part_1.pl 2016_day_04_input.txt
# Answer: 137896

    

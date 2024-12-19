use v5.10; use List::Util qw(sum);

my @inp = map s/\n//r, <>;
my @pat = $inp[0]=~/\w+/g;
my @des = @inp[2..$#inp];
my %patL; push@{ $patL{substr($_,0,1)} }, $_ for @pat; #4speedup

say "Answer: ", sum map{ my $w = ways($_); say "design $_: $w ways"; $w } @des;

sub ways {
    my $str = shift;
    $ways{$str} //= #memoize
    sum
    map $str eq $_ ? 1 : ways( substr($str,length($_))),
    grep $_ eq substr($str, 0, length($_)),

   #@pat                                     #slowish
    @{ $patL{substr($str,0,1)} }             #faster

}

# time perl 2024_day_19_part_2.pl 2024_day_19_example.txt
# time perl 2024_day_19_part_2.pl 2024_day_19_input.txt       # 0.15 sec
# Answer: 761826581538190
    

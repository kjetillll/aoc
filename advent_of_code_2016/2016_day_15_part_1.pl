use v5.10; use strict; use warnings;

my @l = <>;
push @l, "Disc #@{[@l+1]} has 11 positions; at time=0, it is at position 0" if $0 =~ /part_2/;

my $d = 1;
my @d = map { /Disc #\d+ has (\d+) positions; at time=(\d+), it is at position (\d+)/ || die;
              { n => $1, pp => -($3+$d++) % $1 } } @l;
sub plus {
    my $t = 0;
    $t++ while ( $t - $_[0]{pp} ) % $_[0]{n}
            or ( $t - $_[1]{pp} ) % $_[1]{n};
    { n => lcm($_[0]{n}, $_[1]{n}), d => 0, pp => $t }
}

unshift @d, plus( splice @d, 0, 2 ) while @d > 1;

say "Answer: ", $d[0]{pp};

sub gcd { my($a,$b,@r)=@_; @r ? gcd($a,gcd($b,@r)) : $b ? gcd($b, $a % $b) : $a }
sub lcm { my($a,$b,@r)=@_; @r ? lcm($a,lcm($b,@r)) : $a*$b / gcd($a,$b) }


# perl 2016_day_15_part_1.pl 2016_day_15_example.txt
# Answer: 5

# perl 2016_day_15_part_2.pl 2016_day_15_example.txt
# Answer: 85

# perl 2016_day_15_part_1.pl 2016_day_15_input.txt     # 0.06 seconds
# Answer: 400589

# perl 2016_day_15_part_2.pl 2016_day_15_input.txt     # 0.32 seconds
# Answer: 3045959

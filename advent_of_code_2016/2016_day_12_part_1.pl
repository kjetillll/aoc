use v5.10; use strict; use warnings;
my @i = map s/\n//r, <>;
my($ip,$step) = (0,0);
my %r = (a=>0, b=>0, c=>0, d=>0);
while( 0 <= $ip <= $#i ){
    $step++;
    local $_ = $i[$ip];
    my $j = 1;
    if    ( /^cpy (-?\d+) (\D)$/ ) { $r{$2} = $1 }
    elsif ( /^cpy (\D) (\D)$/    ) { $r{$2} = $r{$1} }
    elsif ( /^inc (\D)$/         ) { $r{$1}++    }
    elsif ( /^dec (\D)$/         ) { $r{$1}--    }
    elsif ( /^jnz (\D) (-?\d+)$/ ) { $r{$1} and $j = $2 }
    elsif ( /^jnz (-?\d+) (-?\d+)$/ ) { $1 and $j = $2  }
    else{die$_}
    info() if $ENV{VERBOSE};
    $ip += $j;
}
info();
say "Answer: $r{a}";

sub info {printf"step: $step   ip: %2d   %-20s a: %-6d   b: %-6s   c: %-6s   d: %-6s\n", $ip, $i[$ip]//'', @r{qw(a b c d)}}

# perl 2016_day_12_part_1.pl 2016_day_12_example.txt    # 0.04 seconds
# Answer: 42

# perl 2016_day_12_part_1.pl 2016_day_12_input.txt      # 0.57 seconds
# Answer: 317993

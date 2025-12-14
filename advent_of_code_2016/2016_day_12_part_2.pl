use v5.10; use strict; use warnings;
my($ip,$step) = (0,0);
my %r = (a=>0, b=>0, c=>1, d=>0);  #part 1: c=>0    part 2: c=>1
my @i = map eval(
     /^cpy (-?\d+) ([a-d])$/ ? qq( sub { \$r{$2} = $1;      1 } )
    :/^cpy ([a-d]) ([a-d])$/ ? qq( sub { \$r{$2} = \$r{$1}; 1 } )
    :/^inc ([a-d])$/         ? qq( sub { \$r{$1}++;         1 } )
    :/^dec ([a-d])$/         ? qq( sub { \$r{$1}--;         1 } )
    :/^jnz ([a-d]) (-?\d+)$/ ? qq( sub { \$r{$1} ? $2     : 1 } )
    :/^jnz (-?\d+) (-?\d+)$/ ? qq( sub { $1      ? $2     : 1 } )
    :die$_), <>;
$ip += $i[$ip]->() while 0 <= $ip <= $#i;
say "Answer: $r{a}";

# perl 2016_day_12_part_2.pl 2016_day_12_example.txt    # 0.009 seconds
# Answer: 42

# perl 2016_day_12_part_2.pl 2016_day_12_input.txt      # 3.6 seconds
# Answer: 9227647

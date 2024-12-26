use strict; use warnings; use v5.10;
my @inp = map s,\n,,r,<>;
my(%comp, %conn, %three);
for(@inp){
    my($a,$b) = /\w+/g;
    $comp{$a} = $comp{$b} = $conn{$a,$b} = $conn{$b,$a} = 1;
}
my @puters=keys%comp;
for my $a (@puters){
for my $b (@puters){ next if !$conn{$b,$a};
for my $c (@puters){ next if !$conn{$c,$b} or !$conn{$c,$a};
    $three{join",",sort($a,$b,$c)}++;
}}}
say "three-groups: ".keys%three;
say "Answer: " . grep/\bt/,keys%three;

# time perl 2024_day_23_part_1.pl 2024_day_23_input.txt   # 0.44 sec
# Answer:  1151

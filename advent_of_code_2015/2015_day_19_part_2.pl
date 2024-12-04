use v5.10;
/(\w+)\W+(\w+)/ ? do{ $repl{$2} = $1 } : /\w+/ ? do{ $medicine = $& } : 0 while <>;
say "medicine: $medicine\n";
my $re = join '|', keys %repl;

my $steps = 0;
say ++$steps, " $medicine" while $medicine =~ s/.*\K($re)/$repl{$1}/; #replace far out strangely enough!?!!
say "Answer: $steps";

#Answer: 195

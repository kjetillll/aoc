use strict; use warnings; use v5.10;
my $dial = 50;
my $zeros = 0;
while(<>){
    $dial += eval y/LR/-+/r;
    $zeros++ if $dial % 100 == 0;
}
say "Answer: $zeros";

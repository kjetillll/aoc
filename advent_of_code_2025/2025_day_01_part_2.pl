use strict; use warnings; use v5.10;
my $dial = 50;
my $zeros = 0;
while(<>){
    my($direction, $distance) = /(L|R)(\d+)/;
    #say "$direction   $distance" and next;
    for(1..$distance){
	$dial += $direction eq 'L' ? -1 : 1;
	$zeros++ if $dial % 100 == 0;
    }
}
say "Answer: $zeros";

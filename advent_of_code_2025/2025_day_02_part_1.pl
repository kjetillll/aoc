use strict; use warnings; use v5.10;
my $invalid = 0;
my @l = map[/\d+/g],split',',<>;
for(@l){
    my($a,$b)=@$_;
    print "a: $a   b: $b   ";
    for($a .. $b){
	$invalid += $_ if /^(\d+)\1$/ and print"($_)   ";
    }
    print "so far: $invalid\n";
}
say "Answer: $invalid";

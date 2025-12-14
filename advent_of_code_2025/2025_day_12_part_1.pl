use strict; use warnings; use v5.10;
my @p;
my $maybe_fit = 0;
while(<>){
    if( /^\d:$/ ){
	push @p, '';
    }
    elsif( /^[#.]+$/ ){
	$p[-1] .= $_
    }
    elsif( /^(\d+)x(\d+):/ ){
	my($x, $y) = ($1, $2);
	my @count_p = $' =~ /\d+/g;
	my $area_presents = eval join '+', map pa($_) * $count_p[$_], 0 .. $#count_p;
	say "region area $x x $y = ", $x * $y, "   area_presents: $area_presents";
	$maybe_fit++ if $area_presents <= $x * $y;
    }
}
sub pa { $p[ shift() ] =~ s/#/#/g } #present area
say "Answer maybe: $maybe_fit";

# perl 2025_day_12_part_1.pl 2025_day_12_example.txt
# Answer: 3

# perl 2025_day_12_part_1.pl 2025_day_12_input.txt
# Answer maybe: 497

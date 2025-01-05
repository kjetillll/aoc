my( $tmpl, %ins );
while(<>){
    chomp;
    $tmpl //= $_;
    $ins{$1} = $2 if /(..) -> (.)/;
}

my %c; #count of letter pairs
$c{ substr $tmpl, $_, 2 }++ for 0 .. length($tmpl) - 2;

for ( 1 .. 40 ){
    my %cnew;
    for( keys %c ){
	if( exists $ins{$_} ) {
	    /(.)(.)/;
	    $cnew{ $1 . $ins{$_} } += $c{$_};
	    $cnew{ $ins{$_} . $2 } += $c{$_};
	}
	else {
	    $cnew{$_} = $c{$_};
	}
    }
    %c = %cnew;
}
my %freq; /(.)(.)/, $freq{$1} += $c{$_}, $freq{$2} += $c{$_} for keys %c;
$freq{ substr $tmpl, $_, 1 }++ for 0, -1; #make 1st & last also apear twice in %freq, div by 2 later
my @freq = sort { $b <=> $a } values %freq;
printf "Answer: %d\n", ( $freq[0] - $freq[-1] ) / 2;

# time perl 2021_day_14_part_2.pl 2021_day_14_example.txt  # 2188189693529
# time perl 2021_day_14_part_2.pl 2021_day_14_input.txt    # 0.004 sec
# Answer: 2437698971143

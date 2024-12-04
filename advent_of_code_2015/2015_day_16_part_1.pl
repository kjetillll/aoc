my %tape=(
  children => 3,
  cats => 7,
  samoyeds => 2,
  pomeranians => 3,
  akitas => 0,
  vizslas => 0,
  goldfish => 5,
  trees => 3,
  cars => 2,
  perfumes => 1
);

while(<>){
    /:/;
    my %r = ( $' =~ /\w+/g ); #what you remember about this Sue
    /Sue (\d+)/, print "Answer: $1" if keys(%r) == grep{ $r{$_} == $tape{$_} } keys %r;
}

#perl 2015_day_16_part_1.pl 2015_day_16_input.txt
#Answer: 103

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
    /Sue (\d+)/, print "Answer: $1" if keys(%r) == grep is_match($_, $r{$_}), keys %r;
}

sub is_match {
  my($thing, $r)=@_;
  $thing =~ /^(cats|trees)$/           ? $r >  $tape{$thing} :
  $thing =~ /^(pomeranians|goldfish)$/ ? $r <  $tape{$thing} :
                                         $r == $tape{$thing}
}



#perl 2015_day_16_part_2.pl 2015_day_16_input.txt
#Answer: 405

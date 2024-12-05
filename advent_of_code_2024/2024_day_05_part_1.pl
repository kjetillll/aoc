use v5.10; use List::Util qw(all);

my @lines = map [/\d+/g], <>; #input lines

my @r = grep @$_==2, @lines;  #rules
my @u = grep @$_>2,  @lines;  #updates

say "Answer: ",
    eval                                          #eval that string
    join '+',                                     #make string with + between numbers
    map $$_[ $#$_ / 2 ],  }                       #middle number in those correctly-ordered updates
    grep {                                        #keep only correctly-ordered updates
	my $u = $_;                               # = current update
	my %u; @u{@$u} = ();                      #numbers in this updates as a set to use 'exists' on
	all {                                     #all rules must either:
	    my($a,$b)=@$_;                        #extract numbers in current rule into $a and $b
	    not ( exists$u{$a} and exists$u{$b} ) #...not apply if not both two numbers exists in update
	    or "@$u" =~ /\b$a\b.*\b$b\b/x         #...or have correct order if the rule apply
	}
	@r
    }
    @u

#Answer: 7307

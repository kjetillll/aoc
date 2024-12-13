use Math::Matrix; use v5.10; use List::Util 'sum';
say "Answer: " . sum map {
    my($ax,$ay,$bx,$by,$cx,$cy) = /\d+/g;
    my $ab = Math::Matrix->new( [$ax,$bx, $cx + 10000000000000],
                                [$ay,$by, $cy + 10000000000000] )
             -> solve;
    my($a,$b) = map s/^\d+\.(0{8}|9{8}).*$/int($&+.1)/re,  # fix .000001 | .999999
                $$ab[0][0],
                $$ab[1][0];
    say "a: $a   b: $b";
    "$a$b"!~/\./  ?  $a*3 + $b*1  :  0   #sum for ints
}
split /\n\n/, join'',<>
    
# Answer: 104140871044942

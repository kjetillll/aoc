use v5.10; use Algorithm::Combinatorics qw(permutations); #use Acme::Tools;
my %digit = ( abcefg   => 0,
              cf       => 1,
              acdeg    => 2,
              acdfg    => 3,
              bcdf     => 4,
              abdfg    => 5,
              abdefg   => 6,
              acf      => 7,
              abcdefg  => 8,
              abcdfg   => 9 );
my $search_for = join ' ', sort keys %digit;
die if $search_for ne 'abcdefg abcdfg abcefg abdefg abdfg acdeg acdfg acf bcdf cf';
my @p = map {
          my $y = join '', @$_;
          [ $y, eval qq(sub{map{join'',sort split//}split/\\s+/,pop=~y/a-g/$y/r}) ]
        }
        permutations( [ a .. g ] );
my $answer = 0;
while(<>){
    my($patterns, $code) = map s/^\s*(.*?)\s*$/$1/r, split/\|/;
    my @one   = map ord($_) - ord('a'), $patterns =~ /\b (\w)(\w) \b/x; #*)
    my @seven = map ord($_) - ord('a'), $patterns =~ /\b (\w)(\w)(\w) \b/x; #*)
    my @four  = map ord($_) - ord('a'), $patterns =~ /\b (\w)(\w)(\w)(\w) \b/x; #*)
    my($found, $fun);
    P:
    for(@p){
        ($found, $fun) = @$_;

        substr($found,$_,1) =~ /[cf]/ or next P for @one;   #*)
        substr($found,$_,1) =~ /[acf]/ or next P for @seven;#*)
        substr($found,$_,1) =~ /[bcdf]/ or next P for @four;#*)

        my $digits = join ' ', sort $fun->($patterns);
        last if $digits eq $search_for;
    }
    my $c = join'', map $digit{$_}, $fun->($code);
    say "found: $found   two: $two   c: $c   code: <$code>";   
    $answer += $c;
}
say "Answer: $answer";

# time perl 2021_day_08_part_2.pl 2021_day_08_input.txt    #0.36 sec
# Answer: 982158

#*) not needed, but speeds up x ~8

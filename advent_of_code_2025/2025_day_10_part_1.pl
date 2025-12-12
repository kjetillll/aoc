use strict; use warnings; use v5.10; use Algorithm::Combinatorics 'subsets';

my @count;
while(<>){
    my @m = /\S+/g;
    my $l = oct "0b" . reverse( shift(@m) =~ s/[^\.\#]//gr ) =~ y/#./10/r;
    pop @m; # ignore "joltage" in part 1
    my @b = map eval( join'+',map 2**$_, /\d+/g), @m;
    K:
    for my $k ( 1 .. @b ){
        eval(join'^',@$_) == $l and push(@count, $k) and last K for subsets(\@b,$k);
    }
    #die;
    #say "_: $_\n.: $.   l: $l   ".(srlz($b,'b')=~s/\n//r)."   j: $j\n\n";
}
#say "@{[sort{$a<=>$b}@count]}";
say "@count";
say "Answer: ", eval join '+', @count;

#say "Answer: $max";


# perl 2025_day_10_part_1.pl 2025_day_10_example.txt
# 2 3 2
# Answer: 7

# perl 2025_day_10_part_1.pl 2025_day_10_input.txt     # 0.112 seconds
# Answer???: 404
    

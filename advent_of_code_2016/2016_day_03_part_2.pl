my @line = <>;
my $i = 0;
my @side;
@side[ $i,
       $i +   @line,
       $i + 2*@line ] = /\d+/g and $i++ for @line;

my $answer = 0;
while( @side ){
    my($s1, $s2, $s3) = sort{ $a <=> $b } splice @side, 0, 3;
    $answer++ if $s1 + $s2 > $s3
}
print "Answer: $answer\n";

# perl 2016_day_03_part_2.pl 2016_day_03_input.txt
# Answer: 1544

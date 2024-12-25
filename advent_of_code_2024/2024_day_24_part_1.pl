use v5.10;
sub ev{ my $e = pop()=~s/AND/ & /r=~s/XOR/ ^ /r=~s/OR/ | /r; eval $e }
my(%w,%g);
while(<>){
    chomp;
    $w{$_}=1 for /\b[a-z0-9]{3}\b/g;
    if(/^(\w{3}): ([01])/){
        ev("sub $1 { $2 }");
    }
    elsif(/^(\w{3}) (AND|OR|XOR) (\w{3}) -> (\w{3})$/){
        $g{$4}=1;
        ev("sub $4 { ($1()//die) $2 ($3()//die) }");
    }
}

print "Answer: " . oct( "0b". join"", map &$_(), reverse sort grep/^z/, keys %w),"\n";
# Answer: 51745744348272

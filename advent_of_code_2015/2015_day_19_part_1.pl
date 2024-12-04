while(<>){
    if(   /(\w+) => (\w+)/){ push @{ $repl{$1} }, $2 }
    elsif(/\w+/)           { $medicine = $_          }
}

for my $repl (sort keys %repl){
    for my $with (@{ $repl{$repl} }){
        my $occ = 1;
        while(1){
            my($test, $n, $found) = ($medicine, 1, 0);
            $test =~ s{$repl}{ $n++ == $occ ? do{ $found=1; $with } : $repl }eg;
            $found ? $found{$test}++ : last;
            $occ++
        }
    }
}
print "Answer: ".keys(%found)."\n";

#Answer: 509

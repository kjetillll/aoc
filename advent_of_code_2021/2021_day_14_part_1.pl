#use Acme::Tools;
my($template,%ins);
while(<>){
    chomp;
    $template //= $_;
    $ins{$1} = $2 if /(..) -> (.)/;
}

my %c; $c{ substr($template,$_,2) }++ for 0 .. length($template) - 2;
for(1..10){
    #print "$_: ".srlz(\%c,'c');
    my %cn;
    for(keys%c){
	#die"<$_>" if !$ins{$_};
	if($ins{$_}){
	    /(.)(.)/;
	    $cn{$1.$ins{$_}}+=$c{$_};
	    $cn{$ins{$_}.$2}+=$c{$_};
	}
	else{
	    $cn{$_}=$c{$_};
	}
    }
    %c=%cn;    
}
#print srlz(\%c,'c');
my %freq; /(.)(.)/, $freq{$1}+=$c{$_}, $freq{$2}+=$c{$_} for keys %c;
$freq{substr($template,$_,1)}++ for 0,-1; #make 1st & last also apear twice in %freq
#print srlz(\%freq,'freq');
my @freq = sort{$b<=>$a}values %freq;
#print srlz(\@freq,'freq');
printf "Answer: %d\n", ($freq[0]-$freq[-1])/2; #hm

# time perl 2021_day_14_part_1.pl 2021_day_14_example.txt
# time perl 2021_day_14_part_1.pl 2021_day_14_input.txt    # 0.002 sec
# Answer: 2010


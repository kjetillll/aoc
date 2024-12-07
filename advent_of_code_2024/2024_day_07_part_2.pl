use Acme::Tools;
use v5.10;
L:
while(<>){
    say "L$. -- $_";
    my($test,@n)=/\d+/g;
    my $ops=3**(@n-1);
    for(0..$ops-1){
	my$o=$_;
	my $eq=join('',map{$r="$_".substr('+*!',$o%3,1);$o/=3;$r}@n)=~s,.$,,r;
#	say"<$eq>";
   	1 while $eq=~s/^(\d+)([\+\*\!])(\d+)/$2 eq '+' ? $1+$3 : $2 eq '*' ? $1*$3 : $1.$3/e;
#	die "$eq";
	my @eq = map{($_,shift(@bin))}@n;
#	if(eva(@eq)==$test){
	if($eq==$test){
	    say " new answer: $answer+$test = ".($answer+$test);
	    $answer+=$test;
	    push@a,$test;
	    $ant++;
	    next L;
	}
    }
#    last if ++$i>1
}
say "ant: $ant";
say "Answer: $answer";

#Answer: 


sub eva{
#    say"...@_";
    my @ev=@_;
    my $n=shift@ev;
    while(@ev>1){
	if($ev[0] eq '+'){
	    shift@ev;
	    $n+=shift@ev;
	}
	elsif($ev[0] eq '*'){
	    shift@ev;
	    $n*=shift@ev
	}
	elsif($ev[0] eq '!'){
	    shift@ev;
	    $n.=shift@ev
	}
    }
#    say"...n: $n";#exit if .01>rand;
    
    $n
}

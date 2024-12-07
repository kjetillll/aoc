use Acme::Tools;
use v5.10;
L:
while(<>){
    say;
    my($test,@n)=/\d+/g;
    die if grep!$_,@n;
    if(@n>12){
	1;
    }
    my $ops=2**(@n-1);
    for(0..$ops-1){
	my $bin=sprintf"%0*b",@n-1,$_;
	print "bin: $bin   ";
	$bin=~y/01/+*/;
	my @bin=$bin=~/./g;
#	my $eq=join'',map{"$_".shift@bin}@n;
#   #	my @eq=map{$_,shift@bin}@n;
#   	print "$bin  <$eq>   ";
#   #	print "...$eq\n" while $eq=~s/^(\d+)([\+\*])(\d+)/$2 eq '+' ? $1+$3 : $1*$3/e;
#   #	1 while $eq=~s/^(\d+)([\+\*])(\d+)/$1>$test?next L:$2 eq '+' ? $1+$3 : $1*$3/e;
#   	1 while $eq=~s/^(\d+)([\+\*])(\d+)/$2 eq '+' ? $1+$3 : $1*$3/e;
	#   	print "$eq\n";
	my @eq = map{($_,shift(@bin))}@n;
	if(eva(@eq)==$test){
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

#Answer: 975671981569
writefile('/tmp/a2',join'',map"$_\n",@a);

sub eva{
    say"...@_";
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
    }
    say"...n: $n";#exit if .01>rand;
    
    $n
}

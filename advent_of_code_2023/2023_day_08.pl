use v5.10;
use Acme::Tools qw(srlz);
use List::Util qw(sum);

my@i=split//,<>=~/\w+/?$&:die;
while(<>){
    my($n,$l,$r)=/(\w+)/g;
    next if !$n;
    $n{$n}={L=>$l,R=>$r};
}
#die srlz(\@i,'i').srlz(\%n,'n','',1);
my$steps=0;
my$now='AAA';
while(1){
    last if $now eq 'ZZZ';
    my $i=$i[$steps%@i];
    $now=$n{$now}{$i}//die;
    $steps++;
}
say "steps: $steps";

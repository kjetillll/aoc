use v5.10;
use Acme::Tools qw(srlz);
use List::Util qw(sum);
use List::MoreUtils qw(any);

my@i=split//,<>=~/\w+/?$&:die;
while(<>){
    my($n,$l,$r)=/(\w+)/g;
    next if !$n;
    $n{$n}={L=>$l,R=>$r};
}
my$steps=0;
my @jobs=split/,/,$ENV{JOBS};
my@now=grep/A$/,sort keys%n;
@now=@now[@jobs] if @jobs;
say srlz(\@i,'i');
say srlz(\@now,'now');
#die srlz(\@i,'i').srlz(\%n,'n','',1).srlz(\@now,'now');
say srlz(\@jobs,'jobs');
my $nows=0+@now;
say "nows: ".@now;
open my $fh,'>',"/tmp/job".join('',@jobs) or die;
W:
while(1){
    #last if !grep/[^Z]$/,@now;
    last if !any{/[^Z]$/}@now;
#    my$x="@now ";
#    say"x: <$x>";
#    last;
#    last unless "@now "=~/[A-X] /;

    my $i=$i[$steps%@i];
    my $a=0;
#    ($_=$n{$_}{$i} // die) && /Z$/ && ++$a for @now;
    $_=$n{$_}{$i} // die for @now;
    #    $now=$n{$now}{$i}//die;
    if( $steps%1e4==0 ){
	my $rt=time()-$^T;
	print "steps: $steps   steps pr sek: ".int($steps/($rt+1e-6))."            \r";
	last if $rt>2;
    }
    $steps++;
#    last if $a==@now;
#    /[A-X]$/ and next W for @now; last;
}
say;
say "steps: $steps";

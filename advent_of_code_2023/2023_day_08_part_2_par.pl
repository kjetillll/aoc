use v5.10;
use Acme::Tools qw(srlz);
use List::Util qw(sum);
use List::MoreUtils qw(any);

my@i=split//,<>=~/\w+/?$&:die;
my%n;
while(<>){
    my($n,$l,$r)=/(\w+)/g;
    next if !$n;
    $n{$n}={L=>$l,R=>$r};
}
my$steps=0;
my $job=$ENV{JOB}//die;
my@now=grep/A$/,sort keys%n;
my$now=$now[$job];
#say srlz(\@i,'i');
#say srlz(\@now,'now');
say "nows: ".@now;
say "now start: $now";
say "nodes: ".keys%n;
say "instructions: ".@i;
#die srlz(\@i,'i').srlz(\%n,'n','',1).srlz(\@now,'now');
open my $fh,'>',"/tmp/job$job" or die;
W:
while(1){
    print $fh "steps: $steps $now\n" if $now=~/Z$/;
    my $i=$i[$steps%@i];
    $now=$n{$now}{$i}//die;
    if( $steps%1e4==0 ){
	my $rt=time()-$^T;
	print "steps: $steps   steps pr sek: ".int($steps/($rt+1e-6))."            \r";
	last if $rt>0;
    }
    $steps++;
#    last if $steps>30000;
}
say;
say "steps: $steps";
__END__
for JOB in {0..5};do perl 2023_day_8_part_2_par.pl 2023_day_8_input.txt;head -1 /tmp/job$JOB;done|grep -P 'steps: \d+ \w+Z$'
steps: 20777 ZZZ
steps: 15517 PTZ
steps: 13939 SCZ
steps: 17621 NQZ
steps: 18673 GVZ
steps: 11309 DDZ

perl -MAcme::Tools -lE'@l=(20777,15517,13939,17621,18673,11309);say"@l";say "Løsning: ".lcm(@l);say eval join"*",@l'

Løsning: 13289612809129


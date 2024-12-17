use v5.10; use Carp;
use Acme::Tools qw(srlz random);
use Getopt::Std; my %Opt; getopts('f:t:',\%Opt);
use List::Util qw(min max);
my %i = (0=>'adv',1=>'bxl',2=>'bst',3=>'jnz',4=>'bxc',5=>'out',6=>'bdv',7=>'cdv');
sub run {
    my %r = %{shift()};
    my @p = @{shift()};
    my $ip = 0;
    my @out;
    my $regstr = sub {join", ", map{"$_=>$r{$_}"}sort keys%r};
    my $combo = sub {
	my $opnd = shift;
	0 <= $opnd && $opnd <= 3 ? $opnd
        :$opnd == 4 ? $r{A}
	:$opnd == 5 ? $r{B}
	:$opnd == 6 ? $r{C}
	:$opnd == 7 ? die"Reserved, invalid opnd 7"
        : die "Invalid combo, opnd: $opnd";
    };
#    say "-------------------------";
#    say "Reg: ",&$regstr();
#    say "Program: ",join';',@p;
    while(1){
	last if $ip > $#p;
	my($opcode,$opnd)=@p[$ip,$ip+1];
	my $next = $ip+2;
	my $op = $i{$opcode};
#	say"opcode: $opcode   op: $op   opnd: $opnd   regstr: ".&$regstr();
	if   ( $op eq 'adv' ){ $r{A} = int( $r{A} / 2 ** &$combo($opnd) ) }
	elsif( $op eq 'bxl' ){ $r{B} = $r{B} ^ $opnd }
	elsif( $op eq 'bst' ){ $r{B} = &$combo($opnd) % 8 }
	elsif( $op eq 'jnz' ){ $next = $opnd if $r{A} != 0 }
	elsif( $op eq 'bxc' ){ $r{B} = $r{B} ^ $r{C} }
	elsif( $op eq 'out' ){ push @out, &$combo($opnd) % 8 }
	elsif( $op eq 'bdv' ){ $r{B} = int( $r{A} / 2 ** &$combo($opnd) ) }
	elsif( $op eq 'cdv' ){ $r{C} = int( $r{A} / 2 ** &$combo($opnd) ) }
	else {die "invalid op: $op   opcode: $opcode"}
	$ip = $next;
    }
#    say "run ret: out: @out   r: ".&$regstr();
    (\@out,\%r)
}

use Test::More;
sub test {
    my($out,$r);
    ($out,$r)=run({C=>9},[2,6]); say $$r{B}==1 ? 'ok' : 'NOT OK';
    ($out,$r)=run({A=>10},[5,0,5,1,5,4]); say "@$out" eq '0 1 2' ? 'ok' : 'NOT OK';
    ($out,$r)=run({A=>2024},[0,1,5,4,3,0]); say "@$out" eq '4 2 5 6 7 7 7 7 3 1 0' && $r{A}==0 ? 'ok' : 'NOT OK';
    ($out,$r)=run({B=>29},[1,7]); say $$r{B}==26 ? 'ok' : 'NOT OK';
}

my(%r,@p);
while(<>){
    if   (/Register (\w): (\d+)/){ $r{$1} = $2 }
    elsif(/Program: (\S+)/      ){ @p = split/,/,$1 }
}
printf"%d %17d       $i{$p[$_]}\n", $p[$_], $p[$_+1] for grep$_%2==0,0..$#p;

#$A=$_+8**15, say"A: $A -> @{[ @{ (run({%r,A=>$A},\@p))[0] } ]}" for 0..1e9;exit;


sub sim_for_A{
    my $A=shift;
    my($out,$r)=run({%r,A=>$A},\@p);
    my $sim=0;
#    print "out: @$out   program: @p";
    $sim++ while $p[-$sim-1] == $$out[-$sim-1] and $sim<@p;
    croak "A: $A   out: @$out   p: @p    wrong out len: ".@$out if @$out != @p;
#    print"   sim: $sim\n";
    $sim
}

my($from,$to)=(8**15, 8**16-1);

use List::BinarySearch::XS qw(binsearch_pos);  #alternativ: use Tie::Array::Sorted; 
my $samples=1000;
my $diff=$to-$from;
my $step=($to-$from)/$samples;
my @work =( [-1,$from,$to,$step] );
my($best_sim, $best_A);
while( @work ){
    my($wsim,$from,$to)=@{shift@work};
    next if $seen{$from,$to}++;
    say "work: $wsim $from $to   diff: ".($to-$from)."  diff len: ".length($to-$from)."   best sim: $best_sim (A: $best_A)";
    my $step=($to-$from)/$samples;
    $from=8**15 if $from<8**15;
    #    $to=8**15 if $from<8**15;
    my @A = map int($from+$_*$step),0..$samples;
    for my $A (@A){
	my $sim = sim_for_A($A);
	($best_sim,$best_A)=($sim,$A) if $sim>$best_sim or $sim==$best_sim and $A<$best_A;
	next if $sim<1;
	next if $sim<=$wsim;
	my $nw=[$sim, int($A-$step-1), int($A+$step+1)];
	my $pos = binsearch_pos {$$b[0]<=>$$a[0]} $nw, @work;
	splice @work, $pos, 0, $nw;
    }
    say "round: ".++$r."  work now: ".@work. "      top pri sim: $work[0][0]";
}



#die sim_for_A(207976801319951);

my $max_sim=0;

for my $match (1..16){
    my $diff=$to-$from;
    my $samples=$match<4 ? 1e3 : $match < 6 ? 1e4 : 1e5;
    printf "match sim: $match   samples: $samples   from: %-16d (%-7e)   to: %-16d (%-7e)   diff: %-16d (%-7e)\n", $from, $from, $to, $to, $diff, $diff;
    last if $diff < 1e5;
    my %sim;
    for(0..$samples){
	my $A = int($from + $_*$diff/$samples);
	my $sim=sim_for_A($A);
	$max_sim=$sim if $sim > $max_sim and say"max_sim: $sim for A=$A";
	#print ++$ca."...match: $match   A: $A   sim: $sim\n";
	push@{ $sim{$sim} }, $A;
	last if @{$sim{$sim}}>20 and $match>7;
    }
    print"...simant: ".join(' ',map"$_=>".@{$sim{$_}}, sort {$a<=>$b} keys%sim)."\n";
    die "no sim for match $match" if !exists$sim{$match};
    my $min_sim_match = min @{$sim{$match}};
    my $max_sim_match = max @{$sim{$match}};
    my @not_sim_match = map @{$sim{$_}}, grep$_!=$match, keys %sim;
    $from=max grep $_ < $min_sim_match, @not_sim_match;
    $to  =min grep $_ > $max_sim_match, @not_sim_match;
#    $to  =min @{$sim{$match}}; #min grep $_>$max_sim_match, @not_sim_match;
}
#die srlz(\%sim,'sim','',1);

test();
#my $ol_last=-1;
#my @maybe=(207976801319951);
#my($from,$to)=(207976796143581, 207976803475543); #trial 1 7e6
#my($from,$to)=($maybe[0]-100,$maybe[0]+100);
#my($from,$to)=(207976687699533,207976796143581);

$from=1e12*$Opt{f} if exists$Opt{f};
$to=1e12*$Opt{t} if exists$Opt{t};

my $diff=$to-$from; my $cd=$diff;
printf"run from: %-16d (%-7e)   to: %-16d (%-7e)   diff: %-16d (%-7e)\n",$from, $from, $to, $to, $to-$from, $to-$from;

=pod 
for my $A ($from .. $to) {
    #for my $A (8**15..8**16){
    print "$cd\r" if $cd--%100==0;
    my($out,$r)=run({%r,A=>$A},\@p);
    my $ol=@$out;
    #print"$A   out len: ".@$out."   out: @$out\n";# if $A%1000==0 or $ol!=$ol_last; $ol_last=$ol;
    if("@$out" eq "@p"){
	say "reg A: $A";
	say "program: @p";
	say "out:     @$out";
	say "Answer maybe: $A\n\n";
	last;
    }
}
exit;

=cut

my($from,$to)=(8**15,8**16-1);
($from,$to)=(190593743605202/1.2, 190593743605202*1.2);
for my $d (1..15){
    my $p_lastd = join' ',@p[ $#p-$d+1 .. $#p ];
    printf "searching for: %-30s     between %17d and %17d   (diff: %-17d (%2d))     p: @p\n", $p_lastd, $from, $to, $to-$from,length($to-$from);
    my %found;
    while(@{$found{$p_lastd}} < 50){
	print 0+@{$found{$p_lastd}}," $c\r" if $c++%1e3==0;
	my $A = int(random($from,$to));
	my @out=@{(run({%r,A=>$A},\@p))[0]};
	#say "A: $A   out: @out";
	my $lastd = join' ',@out[ $#out-$d+1 .. $#out ];
	push @{$found{$lastd}}, $A if $lastd eq $p_lastd;
	say "sample A: $A   out: @out   p: @p" if $_==1;
    }
    $_=[min(@$_),max(@$_)] for values%found;
    die "could not find $p_lastd" if !exists$found{$p_lastd};
    ($from,$to) = @{$found{$p_lastd}};
    $from=int($from-($from-$to)/20);
    $to  =int($to  +($from-$to)/20);
    say "For d: $d   p_lastd: $p_lastd   from: $from   to: $to";
    printf "found{%-20s} -> %17d - %17d         (diff: %17d)\n", $_, $found{$_}[0], $found{$_}[1], $found{$_}[1]-$found{$_}[0]
	for sort { $found{$a}[0] <=> $found{$b}[0] } keys%found;
}

while(1){
    my $A=$from;
    my($out,$r)=run({%r,A=>$A},\@p);
    my $ol=@$out;
    print"$A   out len: ".@$out."   out: @$out   vs   program: @p\n";# if $A%1000==0 or $ol!=$ol_last; $ol_last=$ol;
    say "Answer: $A\n\n" and last if "@$out" eq "@p";
    $from+=8**14;
}

__END__

32767   out len: 5   out: 5 5 5 3 2
32768   out len: 6   out: 5 5 5 5 7 4     <-- 8**5 => len 6


262143   out len: 6   out: 5 5 5 5 3 2
262144   out len: 7   out: 5 5 5 5 5 7 4  <-- 8**6 => len 7

Input program: 2,4,1,2,7,5,4,5,0,3,1,7,5,5,3,0 has len 16, thus A btw 8**15 .. 8**16-1

Answer: 207976801319951 too high
Answer: 207976371209812 too high (random check)
Answer: 207976333535901 too high (random check)

207 976 371 209 812

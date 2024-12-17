use v5.10; use Carp;
my $SAMPLES = $ENV{SAMPLES} // 1000; #hm, more is safer? for my input: min ~50, 2000 gives wrong answer
sub compile {
    my @program=@_;
    my $perl='';
    my $add=sub{$perl.=sprintf("    ".shift,@_).";\n"};
    my %op = qw( 0 adv   1 bxl   2 bst   3 jnz   4 bxc   5 out   6 bdv   7 cdv );
    for(grep $_%2==0, 0..$#program){
	my($opcode,$opnd)=@program[$_,$_+1];
	my $op = $op{$opcode};
	say"opcode: $opcode   opnd: $opnd";
	my $combo = 0<=$opnd && $opnd <= 3 ? $opnd : $opnd==4 ? '$rA' : $opnd==5 ? '$rB' : $opnd==6 ? '$rC' : -1; #die"opnd: $opnd";
	if   ( $op eq 'adv' ){ &$add('$rA = int( $rA / 2 ** %s )', $combo) }
	elsif( $op eq 'bxl' ){ &$add('$rB = $rB ^ %s',$opnd) }
	elsif( $op eq 'bst' ){ &$add('$rB = %s % 8',$combo) }
	elsif( $op eq 'jnz' ){ $perl = "do{\n$perl } until \$rA == 0" }
	elsif( $op eq 'bxc' ){ &$add('$rB = $rB ^ $rC') }
	elsif( $op eq 'out' ){ &$add('push @out, %s % 8',$combo) }
	elsif( $op eq 'bdv' ){ &$add('$rB = int( $rA / 2 ** %s)',$combo) }
	elsif( $op eq 'cdv' ){ &$add('$rC = int( $rA / 2 ** %s)',$combo) }
	else {die "op: $op"}
    }
    $perl = sprintf('sub run_program { my($rA,$rB,$rC) = @_; my @out; %s; return @out }',$perl);
    die if $perl=~s/until/until/g > 1;
    say "compiles: $perl";
    eval $perl; $@ and die$@;
}

my(%r,@program);
while(<>){
    if   (/Register (\w): (\d+)/){ $r{$1} = $2 }
    elsif(/Program: (\S+)/      ){ @program = split/,/,$1 }
}
compile(@program);

sub similarity_for_A {
    my $A = shift;
    my @out = run_program( $A, $r{B}, $r{C} ); #override regA
    croak "A: $A   wrong out len: ".@out.", should be ".@program if @out != @program;
    my $sim = 0;
    $sim++ while $program[-$sim-1] == $out[-$sim-1] and $sim<@program;
    return $sim #no of similar elems from end
}

my($from_init, $to_init) = ( 8**(@program-1), 8**@program - 1);
# from-to search boundaries found by looking at output length behaviour
# at different inputs, output length must be equal to program length

use List::BinarySearch::XS qw(binsearch_pos);
my @work = ( [-1, $from_init, $to_init] ); #prioritized work queue: [sim, from, to]
my($best_sim, $best_A); #keeps best so far
my $no = 0;
my %work_seen;
while( @work ){
    my($wsim,$from,$to) = @{shift@work};
    $from = $form_init if $from < $from_init;
    next if $work_seen{$from,$to}++; #needed?
    #next if $best_sim==@program and $from > $best_A; #hm
    my $diff = $to - $from;
    say "work #".++$no."   work queue: ".@work."   wsim: $wsim   from..to: $from..$to   ".
        "diff: $diff   diff len: ".length($diff)."   best similarity A: $best_A (sim $best_sim)";
    last if $best_sim == @program; #an answer found! smallest? output with register A = $A magically gives output equal to @program
    my $step = ($to-$from) / $SAMPLES;
    my @A = $step >= 2 ? (map int($from+$_*$step), 0 .. $SAMPLES) : ($from..$to);
    for my $A (@A){
	my $sim = similarity_for_A($A); # "tail-similarity" with program, eq elems from end
	($best_sim, $best_A) = ($sim, $A)
	    if $sim > $best_sim
	    or $sim == $best_sim and $A < $best_A; #lowest A of eq matches
	next if $sim<1;
	next if $sim<=$wsim;
	my $new_work = [$sim, int($A-$step-1), int($A+$step+1)];
	my $pos = binsearch_pos {$$b[0]<=>$$a[0] || $$a[1]<=>$$b[1]} $new_work, @work;
	splice @work, $pos, 0, $new_work;
	#...insert at prioritized position, most similar is most important
	#prioritize by similarity in index 0 and then least register A in work position index 1
    }
}
my $CORRECT = $ENV{CORRECT} // 190384615275535;
use Acme::Tools qw(avg max min srlz);
say "Answer: $best_A ".($best_A eq $CORRECT ? 'ok   ' : 'wrong')."  samples: $SAMPLES   runtime: ".(time-$^T)."s";

__END__

time SAMPLES=1000 perl 2024_day_17_part_2.pl 2024_day_17_input.txt   # 0.09 sec
Answer: 190384615275535   <-------- right answer with samples 1000

time SAMPLES=2000 perl 2024_day_17_part_2.pl 2024_day_17_input.txt   # 39 sec with sample count 2000
Answer: 207976801319951   <-------- wrong answer with samples 2000
So this program is not perfect!

Imperfect idea for improvement/completion: try lots of samples counts, timeout each
trial at 1-2 sec, and return lowest of answers found as My Answer. Probably something
much smarter is needed for perfection.  Not lowest optimas are output prematurly
when still lower candidate stretches in @work (probably) should be tried.

Run:

time for s in 20 40 80 160 200 220 240 300 500 1000 1500 2000 3000 10000 20000 100000; do
  SAMPLES=$s CORRECT=190384615275535 perl 2024_day_17_part_2.pl 2024_day_17_input.txt
done | grep Answer

time for s in {20..1000}; do SAMPLES=$s CORRECT=190384615275535 perl 2024_day_17_part_2.pl 2024_day_17_input.txt; done | grep Answer #37% wrong

Answer: 190384615275535 ok     samples: 20   runtime: 0s
Answer: 207976801319951 wrong  samples: 40   runtime: 0s
Answer: 190384615275535 ok     samples: 80   runtime: 0s
Answer: 190384625499151 wrong  samples: 160   runtime: 0s
Answer: 190384625499151 wrong  samples: 200   runtime: 0s
Answer: 190384615275535 ok     samples: 220   runtime: 1s
Answer: 190384615275535 ok     samples: 240   runtime: 0s
Answer: 190384625499151 wrong  samples: 300   runtime: 0s
Answer: 190384615275535 ok     samples: 500   runtime: 0s
Answer: 190384615275535 ok     samples: 1000   runtime: 0s
Answer: 190384615275535 ok     samples: 1500   runtime: 0s
Answer: 207976801319951 wrong  samples: 2000   runtime: 39s
Answer: 207976801319951 wrong  samples: 3000   runtime: 91s
Answer: 190384615275535 ok     samples: 10000   runtime: 0s
Answer: 190384625499151 wrong  samples: 20000   runtime: 0s
Answer: 190384625499151 wrong  samples: 100000   runtime: 3s


----the example----

time for s in 20 40 80 160 200 220 240 300 500 1000 1500 2000; do
  SAMPLES=$s CORRECT=117440 perl 2024_day_17_part_2.pl 2024_day_17_example2.txt
done | grep Answer

Answer: 117440 ok     samples: 20   runtime: 0s
Answer: 117440 ok     samples: 40   runtime: 0s
Answer: 117441 wrong  samples: 80   runtime: 0s
Answer: 117440 ok     samples: 160   runtime: 0s
Answer: 117440 ok     samples: 200   runtime: 0s
Answer: 117446 wrong  samples: 220   runtime: 0s
Answer: 117445 wrong  samples: 240   runtime: 0s
Answer: 117441 wrong  samples: 300   runtime: 0s
Answer: 117440 ok     samples: 500   runtime: 0s
Answer: 117440 ok     samples: 1000   runtime: 0s
Answer: 117440 ok     samples: 1500   runtime: 1s
Answer: 117440 ok     samples: 2000   runtime: 0s

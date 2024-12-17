use v5.10; use Carp;
my $SAMPLES = $ENV{SAMPLES} // 1000; #hm, more is safer? for my input: min ~50, 2000 gives wrong answer
my %op = qw( 0 adv   1 bxl   2 bst   3 jnz   4 bxc   5 out   6 bdv   7 cdv );

sub run_program {
    my($regs,@program) = @_;
    my %r = %$regs;
    my $ip = 0;
    my @out;
    my $combo = sub {
        my $opnd = shift;
        0 <= $opnd && $opnd <= 3 ? $opnd
        :$opnd == 4 ? $r{A}
        :$opnd == 5 ? $r{B}
        :$opnd == 6 ? $r{C}
        :$opnd == 7 ? die "Reserved, invalid opnd 7"
        : die "Invalid combo, opnd: $opnd";
    };
    while($ip <= $#program){
        my($opcode,$opnd) = @program[$ip,$ip+1];
        my $next = $ip+2;
        my $op = $op{$opcode};
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
    (\@out,\%r)
}

sub test {
    my($out,$r);
    my $tr = sub{(shift() ? 'ok' : 'NOT OK').' test'}; #tr test result
    ($out,$r) = run_program( {C=>9},   2,6);         say &$tr($$r{B}==1);
    ($out,$r) = run_program( {A=>10},  5,0,5,1,5,4); say &$tr("@$out" eq '0 1 2');
    ($out,$r) = run_program( {A=>2024},0,1,5,4,3,0); say &$tr("@$out" eq '4 2 5 6 7 7 7 7 3 1 0' && $r{A}==0);
    ($out,$r) = run_program( {B=>29},  1,7);         say &$tr($$r{B}==26);
}
my(%r,@program);
while(<>){
    if   (/Register (\w): (\d+)/){ $r{$1} = $2 }
    elsif(/Program: (\S+)/      ){ @program = split/,/,$1 }
}
printf"program: %d %d $op{$program[$_]}\n", @program[$_, $_+1] for grep$_%2==0,0..$#program;
test();

sub similarity_for_A {
    my $A = shift;
    my @out = @{ ( run_program( { %r, A=>$A },@program) )[0] }; #override regA
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
    my $diff = $to - $from;
    say "work #".++$no."   work queue: ".@work."   wsim: $wsim   from..to: $from..$to   ".
        "diff: $diff   diff len: ".length($diff)."   best similarity A: $best_A (sim $best_sim)";
    last if $best_sim == @program; #answer found! output with register A = $A magically gives output equal to @program
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
say "Answer: $best_A ".($best_A eq $CORRECT ? 'ok   ' : 'wrong')."  samples: $SAMPLES   runtime: ".(time-$^T)."s";

__END__

time SAMPLES=1000 perl 2024_day_17_part_2.pl 2024_day_17_input.txt   # 0.65 sec
Answer: 190384615275535   <-------- right answer with samples 1000

time SAMPLES=2000 perl 2024_day_17_part_2.pl 2024_day_17_input.txt   # ~5 sec with
Answer: 207976801319951   <-------- wrong answer with samples 2000

So this program is not completely ok!

Imperfect idea for improvement/completion: try lots of samples counts, timeout each
trial at 1-2 sec, and return lowest of answers found as My Answer. Probably something
much smarter is needed for perfection.

Run:

time for s in 20 40 80 160 200 220 240 300 500 1000 1500 2000; do
  SAMPLES=$s CORRECT=190384615275535 perl 2024_day_17_part_2.pl 2024_day_17_input.txt
done | grep Answer

Answer: 190384615275535 ok     samples: 20   runtime: 0s
Answer: 207976801319951 wrong  samples: 40   runtime: 0s
Answer: 190384615275535 ok     samples: 80   runtime: 1s
Answer: 190384625499151 wrong  samples: 160   runtime: 0s
Answer: 190384625499151 wrong  samples: 200   runtime: 0s
Answer: 190384615275535 ok     samples: 220   runtime: 4s
Answer: 190384615275535 ok     samples: 240   runtime: 1s
Answer: 190384625499151 wrong  samples: 300   runtime: 0s
Answer: 190384615275535 ok     samples: 500   runtime: 0s
Answer: 190384615275535 ok     samples: 1000   runtime: 1s
Answer: 190384615275535 ok     samples: 1500   runtime: 1s
Answer: 207976801319951 wrong  samples: 2000   runtime: 388s


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

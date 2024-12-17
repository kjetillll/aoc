use v5.10;

my(%r,@program);
while(<>){
    if   (/Register (\w): (\d+)/){ $r{$1} = $2 }
    elsif(/Program: (\S+)/      ){ @program = split/,/,$1 }
}
compile(@program);

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

say "program: @program";
my $A = 0;
for my $l (1..16){
    $A *= 8;
    say "l: $l   A: $A";
    for (0 .. 7){
	my @out = run_program( $A, $r{B}, $r{C} );
	say "try A (+$_) = $A   out: @out";
	last if join(' ',(reverse@out    )[0 .. $l-1]) #siste $l like
	     eq join(' ',(reverse@program)[0 .. $l-1]);
	$A++
    }
}
say "Answer: $A";

# time perl 2024_day_17_part_2_better.pl 2024_day_17_input.txt    #0.01 sec
# Answer: 190384615275535

# 2024_day_17_part_2.pl          me, myself and I
# 2024_day_17_part_2_better.pl   stole idea

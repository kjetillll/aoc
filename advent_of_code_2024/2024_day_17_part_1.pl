use v5.10;
use Acme::Tools;
sub run {
    my %r = %{shift()};
    my @p = @{shift()};
    my %i = (0=>'adv',1=>'bxl',2=>'bst',3=>'jnz',4=>'bxc',5=>'out',6=>'bdv',7=>'cdv');
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
    say "-------------------------";
    say "Reg: ",&$regstr();
    say "Program: ",join';',@p;
    while(1){
        last if $ip > $#p;
        my($opcode,$opnd)=@p[$ip,$ip+1];
        my $next = $ip+2;
        my $op = $i{$opcode};
        say"opcode: $opcode   op: $op   opnd: $opnd   regstr: ".&$regstr();
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
    say "run ret: out: @out   r: ".&$regstr();
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
test();

my(%r,@p);
while(<>){
    if   (/Register (\w): (\d+)/){ $r{$1} = $2 }
    elsif(/Program: (\S+)/      ){ @p = split/,/,$1 }
}
say "Answer: ", join',',@{ (run(\%r,\@p))[0] };

use v5.10;
use List::Util qw(min max sum);

while(<>){
    print;
    my @d = /[-\w]+/g;
    $in{$d[0]} = {@d[1..$#d]}
}
my @in = sort keys %in; #ingredients
my @prop = qw(capacity durability flavor texture);
my $max;
N:
for my $n ( 0 .. 101 ** (@in-1) ){ #trials
    my @ts;
    my $ts_sum = 0;
    for(@in){
        push @ts, $_ ne $in[-1] ? $n % 101 : 100 - $ts_sum;
        $n /= 101;
        $ts_sum += $ts[-1];
        next N if $ts_sum > 100;
    }
    my %ts; @ts{@in} = @ts; #teaspoons of each ingredient in this trial
    my $score = 1;
    for my $prop (@prop){
        my $f;
        if("@ts{@in}" eq "44 56"){ #example case
            $f = join' + ', map "$ts{$_}*$in{$_}{$prop}", @in;
            say "A $prop of $f = ".($f=eval($f));
        }
        else{
            $f = sum map $ts{$_} * $in{$_}{$prop}, @in;
        }
        next N if $f < 0;
        $score *= $f;
    }
    $max = $score if $score > $max;
}
say "Answer: $max";

#time perl 2015_day_15_part_1.pl 2015_day_15_example.txt
#time perl 2015_day_15_part_1.pl 2015_day_15_input.txt #0.98 sec
#Answer: 13882464

use v5.10; use strict; use warnings;
my $rows = $ARGV[0] =~ /example/ ? 10 : $0 =~ /part_2/ ? 40 : 400000;
my @t = ( <> =~ s/[^\^\.]//gr );

say "Answer part 1: ", eval join'+',map y/././, @t;

my $s = join'','a'..'z';

push @t, row($t[-1]) while @t < $rows;
my %mem;
my $answer = eval join '+', map y/././, @t;
say "mem keys: ".keys(%mem) if $ENV{VERBOSE};
say "Answer part 2: $answer";


sub r2 {
    my $s = shift;
    $mem{$s} //= length($s)>14
    ? do {
        my @a = $s=~/.{1,9}/g;
        $a[$_] =~ s{.*}{ ($_==0?'.':substr($a[$_-1],-2,1)).$&.($_==$#a?'.':substr($a[$_+1],0,1)) }e for 0 .. $#a;
        join('', map r2($_), @a) =~ s/^.//r =~ s/.$//r;
    }
    : join('',
           map {
               my $tri=substr($s,$_-1,3);
               $tri eq '^^.' ? '^'
              :$tri eq '.^^' ? '^'
              :$tri eq '^..' ? '^'
              :$tri eq '..^' ? '^'
              :                '.';
           } 1 .. length($s)-2 )
}

sub row {
    my $last = ".".shift().".";
    join'',
    map {
        my $tri=substr($last,$_-1,3);
        $tri eq '^^.' ? '^'
       :$tri eq '.^^' ? '^'
       :$tri eq '^..' ? '^'
       :$tri eq '..^' ? '^'
       :                '.';
    } 1 .. length($last)-2
}

# perl 2016_day_18_part_1.pl 2016_day_18_input.txt      # 10.5 seconds
# Answer part 1: 49
# Answer part 2: 20003246

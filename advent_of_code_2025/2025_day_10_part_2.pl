use strict; use warnings; use v5.10;
my $sum = '';
my @l = map s/\n//r, <>;
my @az = 'a' .. 'z';

for my $line ( 0 .. $#l ){
    $ENV{VERBOSE} and say "========== $line/$#l   $l[$line]";
    my @m = $l[$line] =~ /\S+/g;
    shift @m; #ignore in part 2
    my @j = pop(@m) =~ /\d+/g;
    my @b = map { { map { $_ => 1 } (/\d+/g) } } @m;
    my $min = 'min: ' . join(' + ', @az[0 .. $#b]) . ';';
    my @lp = map{ my $i = $_; join(" + ", map { exists $b[$_]{$i} ? $az[$_] : () } 0 .. $#b) . " = $j[$i];" } 0 .. $#j;
    $ENV{VERBOSE} and say for @lp;
    my $file="/tmp/problem_$line.lp";
    open my $fh, '>', $file or die;
    say $fh $min;
    say $fh $_ for @lp;
    say $fh $min =~ s/min:/int/r =~ s/ \+/,/gr;
    close($fh);
    my @bp = qx(lp_solve $file) =~ /^[a-z]\s+(\d+)/mg; #sudo apt install liblpsolve55-dev
    my $bp = join" + ", @bp; #button presses
    my $inc = join' + ', map "$bp[$_]*" . keys( %{ $b[$_] } ), 0 .. $#b;
    $ENV{VERBOSE} and say "button presses: $bp = ", eval $bp, "   inc: $inc = ", eval $inc, "   sumj: ", eval join'+', @j;
    $sum .= " + " . eval $bp;
}
say "Button presses: $sum = ", eval $sum;
say "Answer: ",eval $sum;

# perl 2025_day_10_part_2.pl 2025_day_10_example.txt
# Button presses:  + 10 + 12 + 11 = 33
# Answer: 33

# perl 2025_day_10_part_2.pl 2025_day_10_input.txt     # 0.236 seconds
# Button presses:  + 32 + 114 + 89 + 75 + 102 + 55 + 67 + ...  + 155 + 188 = 16474
# Answer: 16474

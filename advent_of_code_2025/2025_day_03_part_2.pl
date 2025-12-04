use strict; use warnings; use v5.10; use List::Util 'reduce';
my $digits = 12;
my $sum = 0;
for my $line ( map [ /\d/g ], <> ){
    my $i = 0;
    my $ds = join'',map{
        $i = max_index( @$line[ $i .. $#$line - $digits + $_ ] );
        $$line[$i];
    }
    1 .. $digits;
    say "ds: $ds" if $ENV{VERBOSE};
    $sum += $ds;
}
say "Answer: $sum";

sub max_index { reduce { $_[$a] > $_[$b] ? $a : $b } reverse 0 .. $#_ }

# perl 2025_day_03_part_2.pl 2025_day_03_example.txt  # 0.009 seconds
# Answer: 3121910778619

# perl 2025_day_03_part_2.pl 2025_day_03_input.txt   # 0.021 seconds
# Answer: 171528556468625

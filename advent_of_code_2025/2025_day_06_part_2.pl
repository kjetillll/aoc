use strict; use warnings; use v5.10;
my($i, @l, @op);
$i=0, map push( @{ $l[$i++] }, $_ ), /./g while <>;
my @o = ( [] );
for( @l ){
    push @op, pop @$_ if $$_[-1] =~ /[+*]/;
    push @o, [] and next if "@$_" !~ /\d/;
    push @{ $o[-1] }, join '', @$_;
}
say "Answer: ", eval join '+', map eval(join shift(@op), @$_), @o;



# perl 2025_day_06_part_2.pl  2025_day_06_example.txt
# Answer: 3263827

# perl 2025_day_06_part_2.pl  2025_day_06_input.txt    # 0.020 seconds
# Answer: 9581313737063

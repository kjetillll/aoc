use strict; use warnings; use v5.10;
my @inp=split/\n\n/,join('',<>)=~s/\n$//r;
my @l = grep s/^#{5}\n//, @inp; ##### at top    --> locks
my @k = grep s/\n#{5}$//, @inp; ##### at bottom --> keys
for(@l,@k){  # replace drawings with count vectors
    my($i,@i) = (0);
    $_ eq "\n" ? ($i=0) : ( $i[$i++] += $_ eq '#' ? 1 : 0 ) for /./sg;
    $_ = \@i;
}
say "locks: ".@l."   keys: ".@k;
my $answer = 0;
my $columns = @{ $l[0] };
for my $l ( @l ){
for my $k ( @k ){
    my $fit = 1;
    for my $c ( 0 .. $columns-1 ){
        $fit = 0, last if $$l[$c] + $$k[$c] > 5;
    }
    #say "Lock @$l and key @$k: " . ( $fit ? 'fits' : 'overlaps' );
    $answer += $fit;
}}
say "Answer: $answer";

# time perl 2024_day_25_part_1.pl 2024_day_25_input.txt         # 0.03 sec
# Answer: 3114

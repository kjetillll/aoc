use strict; use warnings; use v5.10; use List::Util qw(max);
my %seqsum;
while(<>){
    my($s, $prev, @diff, %seen) = ($_);
    for( 1 .. 2000 ){
        my $ones = $s % 10;
        push @diff, $ones - $prev if defined $prev;
        if( @diff == 4 ){
            my $seq = "@diff";
            $seqsum{$seq} += $ones if !$seen{$seq}++;
            shift @diff;
        }
        $prev = $ones;
        ($s ^= $s <<  6) %= 16777216; # * 64 % 1<<24
        ($s ^= $s >>  5) %= 16777216; # / 32
        ($s ^= $s << 11) %= 16777216; # * 2048
    }
}
say "seqs: " . keys %seqsum;
say "Answer: " . max values %seqsum;

# Answer: 1998
# time perl 2024_day_22_part_2.pl 2024_day_22_example2.txt    # Answer: 23   0.017 sec
# time perl 2024_day_22_part_2.pl 2024_day_22_input.txt       # Answer: 1998   3.54 sec

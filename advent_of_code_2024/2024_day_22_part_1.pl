use v5.10;
say "Answer: " . eval join '+', map {
    my($secret) = /\d+/g;
    ($secret ^= $secret*64)   %= 16777216,
    ($secret ^= $secret>>5)   %= 16777216,  # / 32
    ($secret ^= $secret*2048) %= 16777216
        for 1..2000;
    #print "$inp: $secret\n";
    $secret;
} <>

# time perl 2024_day_22_part_1.pl 2024_day_22_input.txt   # 0.83 sec
# Answer: 17724064040

while(<>){
    my($test, @n) = /\d+/g;
    for my $o (0 .. 3 ** $#n - 1){
        my @e = @n;
        splice @e, 0, 2, $o % 3 == 0 ? $e[0] + $e[1]
                        :$o % 3 == 1 ? $e[0] * $e[1]
                        :              $e[0] . $e[1] and $o/=3 while @e > 1;
        $answer += $test, last if $e[0] == $test;
    }
    print "line: $.   answer so far: $answer     $_"
}
print "Answer: $answer\n"

#time perl 2024_day_07_part_2.pl 2024_day_07_input.txt   # 42 sec
#Answer: 223472064194845

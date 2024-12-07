while(<>){
    my($test, @n) = /\d+/g;
    for my $o (0   ..   3 ** $#n - 1){
        my @e = @n;
        unshift @e, $o % 3 == 0 ? shift(@e) + shift(@e)
	          : $o % 3 == 1 ? shift(@e) * shift(@e)
                  :               shift(@e) . shift(@e) and $o /= 3 while @e > 1;
        $answer += $test, last if $e[0] == $test
    }
    print "line: $.   answer so far: $answer     $_"
}
print "Answer: $answer\n"

#time perl 2024_day_07_part_2.pl 2024_day_07_input.txt   # 41 sec
#Answer: 223472064194845

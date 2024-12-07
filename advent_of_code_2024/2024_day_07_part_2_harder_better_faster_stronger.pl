sub tall {
    my($test, $a, $b, @resten) = @_;
    @_ == 2
        ? $test == $a ? $test : 0
	: tall($test, $a + $b, @resten) ||
  	  tall($test, $a * $b, @resten) ||
	  tall($test, $a . $b, @resten)
}
print "Answer: ", eval join '+', map tall( /\d+/g ), <>


#time perl 2024_day_07_part_2_harder_better_faster_stronger.pl 2024_day_07_input.txt   # 4.63 sec
#Answer: 223472064194845

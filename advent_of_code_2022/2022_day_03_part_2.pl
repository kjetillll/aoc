print "Answer: ", eval join '+', map ord()-($_ le Z?38:96), map /(\w).*\n.*\1.*\n.*\1/g, join('',<>) =~ /.*\n.*\n.*\n/g

#perl 2022_day_03_part_2.pl 2022_day_03_input.txt
#Answer: 2758

print "Answer: ", eval join '+', map ord()-($_ le Z?38:96), map s,.{@{[length()/2-.5]}}\K,-,r =~ /(\w).*-.*\1/g, <>

#perl 2022_day_03_part_1.pl 2022_day_03_input.txt
#Answer: 7553

$/="\n\n"; print "Answer: ", ( sort { $b <=> $a } map eval s/\d+/+$&/gr, <> )[0]

#perl 2022_day_01_part_1.pl 2022_day_01_input.txt
#Answer: 70698

print "Answer: ", eval join '+', map { /-/; grep /^(\d+)\1+$/, $` .. $' } map split(','), <>

# perl 2025_day_02_part_2.pl 2025_day_02_input.txt    # 1.10 seconds
# Answer: 31680313976

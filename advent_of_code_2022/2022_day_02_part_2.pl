print "Answer: ", eval join '+', map {
    {            # Opponent  You must  Must choose  Shape score Result score
                 # --------- --------- ------------ ----------- ------------
'A X' => 3+0,    # Rock      Lose      Scissors     3           0
'A Y' => 1+3,    # Rock      Draw      Rock         1           3
'A Z' => 2+6,    # Rock      Win       Paper        2           6
'B X' => 1+0,    # Paper     Lose      Rock         1           0
'B Y' => 2+3,    # Paper     Draw      Paper        2           3
'B Z' => 3+6,    # Paper     Win       Scissors     3           6
'C X' => 2+0,    # Scissors  Lose      Paper        2           0
'C Y' => 3+3,    # Scissors  Draw      Scissors     3           3
'C Z' => 1+6,    # Scissors  Win       Rock         1           6
    }->{ s/\n//r }
}<>

#perl 2022_day_02_part_2.pl 2022_day_02_input.txt
#Answer: 14859

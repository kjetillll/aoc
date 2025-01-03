my @score;
while(<>){
    1 while s{ [\(\[\{\<]
               [\)\]\}\>] }{ next if 0 > index( '()[]{}<>', $& ) }xe;
    push @score, 0;
    ( $score[-1] *= 5 ) += { '('=>1, '['=>2, '{'=>3, '<'=>4 }->{ $& } while s/.$//;
}
print "Answer: ", ( sort { $a <=> $b } @score )[ $#score / 2 ], "\n";

# time perl 2021_day_10_part_2.pl 2021_day_10_input.txt     # 0.007 sec
# Answer: 4330777059

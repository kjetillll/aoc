my @dir = ( [0,-1], [1,0], [0,1], [-1,0] ); #north east south west
while(<>){
    my($x, $y, $i) = (0,0,0);
    for(/[RL]\d+/g){
        $i += /R/ ? 1 : /L/ ? -1 : die;
        $x += $' * $dir[ $i % 4 ][0];
        $y += $' * $dir[ $i % 4 ][1];
        print "i: $i   steps: $'   x: $x   y: $y\n" if $ENV{VERBOSE};
    }
    print "Answer: ", abs($x) + abs($y), "\n";
}

# perl 2016_day_01_part_1.pl 2016_day_01_example.txt
# Answer: 5
# Answer: 2
# Answer: 12

# perl 2016_day_01_part_1.pl 2016_day_01_input.txt
# Answer: 239

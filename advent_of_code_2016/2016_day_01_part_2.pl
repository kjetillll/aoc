my @dir = ( [0,-1], [1,0], [0,1], [-1,0] ); #north east south west
my %visited_times;
while(<>){
    my($x, $y, $i) = (0,0,0);
    my %visited_times;
    $visited_times{$x, $y} = 1;
    INSTRUCTION:
    for(/[RL]\d+/g){
        $i += /R/ ? 1 : /L/ ? -1 : die;
        my $steps = $';
        for(1..$steps){
            $x += $dir[ $i % 4 ][0];
            $y += $dir[ $i % 4 ][1];
            ++$visited_times{$x,$y} == 2 and last INSTRUCTION;
        }
        print "i: $i   steps: $'   x: $x   y: $y\n" if $ENV{VERBOSE};
    }
    print "Answer: ", abs($x) + abs($y), "\n";
}

# perl 2016_day_01_part_2.pl 2016_day_01_example_part_2.txt
# Answer: 4
# perl 2016_day_01_part_2.pl 2016_day_01_input.txt
# Answer: 141
    

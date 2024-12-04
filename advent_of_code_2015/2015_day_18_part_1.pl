my($y,%grid)=(0);
while(<>){
    chomp;
    my $x = 0;
    $grid{$x++,$y} = /#/ ? 1 : 0 for /./g;
    $y++;
}

for(1..100){
    my %newgrid;
    for( keys %grid ){
        my($x,$y) = /\d+/g;
        my $n = $grid{$x-1,$y-1} + $grid{$x,$y-1} + $grid{$x+1,$y-1}
              + $grid{$x-1,$y  } +                  $grid{$x+1,$y  }
              + $grid{$x-1,$y+1} + $grid{$x,$y+1} + $grid{$x+1,$y+1};
        $newgrid{$x,$y} = $grid{$x,$y} ? $n==2||$n==3||0 : $n==3||0
    }
    %grid = %newgrid
}

print "Answer: ", eval join '+', values %grid;

#time perl 2015_day_18_part_1.pl 2015_day_18_input.txt #2.29 sec
#Answer: 1061

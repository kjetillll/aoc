my($dots, $folds) = split /\n\n/, join('',<>);
my %dot = map { s/,/$;/r => '#' } split /\n/, $dots;
my @fold = map [ /fold along (x|y)=(\d+)/ ], grep $_, split /\n/, $folds;

for( @fold[0] ) {  #first only
    my($axis, $val) = @$_;
    for( keys %dot ){
        my($x, $y) = /\d+/g;
        delete $dot{$_};
        $x = 2*$val-$x if $axis eq 'x' and $x > $val;
        $y = 2*$val-$y if $axis eq 'y' and $y > $val;
        $dot{$x, $y} = '#';
    }
}
printf "Answer: %d\n", 0 + keys %dot;

# time perl 2021_day_13_part_1.pl 2021_day_13_input.txt      # 0.003 sec
# Answer: 592

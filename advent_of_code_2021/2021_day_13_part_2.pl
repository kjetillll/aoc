my($dots, $folds) = split /\n\n/, join('',<>);
my %dot = map { s/,/$;/r => '#' } split /\n/, $dots;
my @fold = map [ /fold along (x|y)=(\d+)/ ], grep $_, split /\n/, $folds;

for( @fold ) {
    my($axis, $along) = @$_;
    %dot = map {
        my($x, $y) = /\d+/g;
        join( $; , $axis eq 'x' && $x > $along ? 2 * $along - $x : $x,
                   $axis eq 'y' && $y > $along ? 2 * $along - $y : $y ) => '#'
    }
    keys %dot
}

print "Answer:\n";
my @x = sort {$a<=>$b} map { my($x, $y) = /\d+/g; $x } keys %dot;
my @y = sort {$a<=>$b} map { my($x, $y) = /\d+/g; $y } keys %dot;
for my $y ( $y[0] .. $y[-1] ){
for my $x ( $x[0] .. $x[-1] ){ print $dot{$x, $y} // '.' }print"\n"}

__END__

time perl 2021_day_13_part_2.pl 2021_day_13_input.txt      # 0.006 sec
Answer:
..##..##...##....##.####.####.#..#.#..#
...#.#..#.#..#....#.#....#....#.#..#..#
...#.#....#..#....#.###..###..##...#..#
...#.#.##.####....#.#....#....#.#..#..#
#..#.#..#.#..#.#..#.#....#....#.#..#..#
.##...###.#..#..##..####.#....#..#..##.

Answer: JGAJEFKU

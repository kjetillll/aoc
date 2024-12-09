use v5.10;
my($x,$y,%grid,%freq,%antinode)=(0,0);
while(<>){
    for(/./g){
        push @{ $freq{$_} }, [$x,$y] if /\w/;
        $grid{$x++,$y} = $_;
    }
    $x=0; $y++;
}
say "count grid: ".keys%grid;
say "count letters: ".keys%freq;
for my $letter (sort keys%freq){
    my @lst = @{$freq{$letter}};
    for my $p1 ( 0 .. $#lst ){
    for my $p2 ( 0 .. $#lst ){
        next if $p1 == $p2;
        my($x1,$y1,$x2,$y2) = (@{$lst[$p1]},
                               @{$lst[$p2]});
        for(0..50){
            my $ax = $x1 - $_ * ($x2-$x1);
            my $ay = $y1 - $_ * ($y2-$y1);
            $antinode{$ax,$ay}++ if exists $grid{$ax,$ay};
        }
    }}
}
say "Answer: ".keys%antinode;

#Answer: 955

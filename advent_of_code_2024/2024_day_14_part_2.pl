my @r = map [/-?\d+/g] ,<>;  #the robots
my $w = @r == 12 ? 11 : 101; #width, 12 robots in 2024_day_14_example.txt
my $h = @r == 12 ? 7  : 103; #height
my $s = 0;                   #seconds so far
my $grid_empty = ( "." x $w ."\n" ) x $h; #grid of periods
while(1){
    my $grid = $grid_empty;
    my $r = 0;
    for(@r){
        my $x = ( $$_[0] + $$_[2] * $s) % $w;
        my $y = ( $$_[1] + $$_[3] * $s) % $h;
        substr($grid, $x + $y * ($w + 1), 1) = $r++ % 10;
    }
    if( $grid =~ /\d{9}/ ){ # xmas tree very AI pattern matching...
        print $grid."Answer: $s sekunder\n";
        exit;
    }
    $s++;
}
#Answer: 6752

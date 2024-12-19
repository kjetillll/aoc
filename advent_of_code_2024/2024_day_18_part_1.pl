use v5.10;
use List::Util qw(max);
my @inp = <>;
my $w = 1+max(map/\d+/g,@inp); #die$w;
my $n = $w==7?12:1024;
@inp = @inp[0..$n-1];
$grid{join$;,/\d+/g} = '#' for @inp;
show(%grid);
my @work = ([0,0,0]);
while(@work){
    my($x,$y,$step) = @{shift@work};
    next if ( $steps{$x, $y} // -1 ) == $step;
    if( $x==$w-1 and $y==$w-1 ){
        show(%grid,map{$_=>'O'}keys%steps);
        say "Answer: $step       ...steps to south-east corner";
        last;
    }
    #grid(%grid,map{$_=>'O'}keys%steps) if ++$c%1000==0 and say"w: ".@work;
    $steps{$x,$y} = $step;
    for( [1,0],[0,1],[-1,0],[0,-1] ) {
        my($dx,$dy) = @$_;
        my($nx,$ny) = ($x+$dx, $y+$dy);
        next if $nx < 0 or $nx >= $w;
        next if $ny < 0 or $ny >= $w;
        next if $grid{$nx,$ny} eq '#';
        next if $step >= ( $steps{$nx,$ny} // 9e9 );
        push@work,[$nx,$ny,$step+1] if $step < ($steps{$nx,$ny} // 9e9);
    }
}

sub show {my%g=@_;for$y(0..$w-1){for$x(0..$w-1){print$g{$x,$y}//'.'}print$/}print$/}

# time perl 2024_day_18_part_1.pl 2024_day_18_input.txt    #0.05 sec
# Answer: 348

use v5.10;
my @inp = <>;
my $w = 1+(sort{$b<=>$a}map/\d+/g,@inp)[0]; #width = 1+max coord
MAZE:
for my $first ( 1024 .. $#inp ){
    my @part = @inp[ 0 .. $first-1 ];
    my(%grid, %steps);
    $grid{ join $;, /\d+/g} = '#' for @part;
    my @work = ( [0,0,0] );
    while( @work ){ #bfs
        my($x, $y, $step) = @{shift@work};
        next MAZE if $x == $w-1 and $y == $w-1 and say "first: $first   steps to south-east corner: $step";
        next if ($steps{$x, $y} // -1 ) == $step;
        $steps{$x,$y} = $step;
        for( [1,0], [0,1], [-1,0], [0,-1] ){
            my($dx,$dy) = @$_;
            my($nx,$ny) = ($x+$dx, $y+$dy);
            next if $nx < 0 or $nx >= $w;
            next if $ny < 0 or $ny >= $w;
            next if $grid{$nx,$ny} eq '#';
            next if $step >= ( $steps{$nx,$ny} // 9e9 );
            push @work, [$nx, $ny, $step+1];
        }
    }
    my($lastx,$lasty) = $part[-1] =~ /\d+/g; 
    show( %grid, (map{$_=>'O'}keys%steps), "$lastx$;$lasty" => redX() );
    say "Answer: $lastx,$lasty";
    last;
}

sub show{my%g=@_;for$y(0..$w-1){for$x(0..$w-1){print$g{$x,$y}//'.'}print$/}print$/}
sub redX {join'',map chr,27,91,51,49,109,88,27,91,48,109}

# time perl 2024_day_18_part_2.pl 2024_day_18_partut.txt     # 18.1 sec after 2881 "bytes"
# Answer: 54,44

use v5.10; use List::Util 'all';

my @word = "XMAS"=~/./g;
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
for( keys %grid ){
    next if $grid{$_} ne $word[0]; #unødv speedup
    my($x,$y)=split/$;/;
    $count += grep { my($dx,$dy)=@$_; all { $grid{ $x + $_*$dx, $y + $_*$dy } eq $word[$_] } 0 .. $#word }
              ([1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]); #8 directions/søkretninger
}
say "Answer: $count";

#time perl 2024_day_04_part_1.pl 2024_day_04_input.txt #0.10 sec
#Answer: 2464

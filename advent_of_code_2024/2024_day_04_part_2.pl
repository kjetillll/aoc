use v5.10; use List::Util qw(all any); use constant { dx=>1, dy=>2, letter=>0 };

my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y}=$_ for /./g; $y++; $x=0 } #read input

for( keys %grid ){
    next if $grid{$_} ne 'A'; #unødv speedup
    my($x,$y) = /\d+/g;
    $count++ if any{ all{ $grid{ $x + $$_[dx], $y + $$_[dy] } eq $$_[letter] } @$_ }
    [ ['A',0,0], ['M',-1,-1] ,['S',1,1], ['M',1,-1], ['S',-1,1] ],
    [ ['A',0,0], ['S',-1,-1] ,['M',1,1], ['M',1,-1], ['S',-1,1] ],
    [ ['A',0,0], ['M',-1,-1] ,['S',1,1], ['S',1,-1], ['M',-1,1] ],
    [ ['A',0,0], ['S',-1,-1] ,['M',1,1], ['S',1,-1], ['M',-1,1] ]
}
say "Answer: $count";

#time perl 2024_day_04_part_2.pl 2024_day_04_input.txt #0.051 sec
#Answer: 1982

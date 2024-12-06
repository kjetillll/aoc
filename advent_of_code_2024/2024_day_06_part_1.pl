use v5.10;

($x,$y) = (0,0);
while(<>){
    chomp;
    $w=length; $w!~/^(130|10)$/ and die;
    $grid{$x++,$y}=$_ for /./g;
    $x=0;$y++;    
}

$grid{$_}eq'^' and ($x,$y)=/\d+/g for keys%grid;
my $d='U';
say "x: $x   y: $y   d: $d";
%d=(
    U=>['R',0,-1],
    R=>['D',1,0],
    D=>['L',0,1],
    L=>['U',-1,0],
    );
while( exists $grid{$x,$y} ) {
    my($next,$dx,$dy)=@{$d{$d}};
    $grid{$x,$y}=~s/[\.\^]/X/;
    $grid{$x+$dx,$y+$dy}=~/#/ and $d=$d{$d}[0] and ($dx,$dy)=@{$d{$d}}[1,2];
    $x+=$dx; $y+=$dy;
}

#for$y(0..$w-1){for$x(0..$w-1){print$grid{$x,$y}}print"\n"}

say "Answer: ", 0+grep/X/,values%grid;
#Answer: 4903

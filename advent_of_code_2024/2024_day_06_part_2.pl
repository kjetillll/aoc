use v5.10;
my($x,$y,%grid) = (0,0);
while(<>){
    chomp;
    $w=length; $w!~/^(130|10)$/ and die;
    $grid{$x++,$y}=$_ for /./g;
    $x=0;$y++;    
}
($startx,$starty) = /\d+/g for grep $grid{$_} eq '^', keys%grid;
my %d = ( U => [ R , 0,-1 ],
          R => [ D , 1, 0 ],
          D => [ L , 0, 1 ],
          L => [ U ,-1, 0 ] );
my $loops = 0;
for my $ox ( 0 .. $w-1){ say"ox: $ox   loops so far: $loops";
for my $oy ( 0 .. $w-1){
    my($d,$x,$y,%been) = ('U',$startx,$starty);
    $grid{$ox,$oy} =~ s/\./O/ or next;
    while( exists $grid{$x,$y} ) {
        ++$loops and last if $been{$x,$y,$d}++;
        my($next,$dx,$dy) = @{$d{$d}};
        $d = $next and ($next,$dx,$dy) = @{$d{$d}} while $grid{$x+$dx,$y+$dy} =~ /[#O]/;
        $x += $dx; $y += $dy;
    }
    $grid{$ox,$oy} = '.';
}}
say "Answer: $loops";

#time perl 2024_day_06_part_2.pl 2024_day_06_input.txt   # 1m 35sec
#Answer: 1911

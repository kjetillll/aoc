use v5.10;
use Acme::Tools 'srlz';
my($x,$y,%grid)=(0,0);
while(<>){
    chomp;
    $w=length; $w!~/^(130|10)$/ and die;
    $grid{$x++,$y}=$_ for /./g;
    $x=0;$y++;    
}
#print srlz(\%grid,'grid','',1);
$grid{$_}eq'^' and ($startx,$starty)=/\d+/g for keys%grid;
my %org_grid=%grid;
my%d=(
    U=>['R',0,-1],
    R=>['D',1,0],
    D=>['L',0,1],
    L=>['U',-1,0],
    );

my $loops=0;
for my $ox(0..$w-1){ say"ox: $ox   loops: $loops";
for my $oy(0..$w-1){
    %grid = %org_grid;
    my($d,$x,$y)=('U',$startx,$starty);
    $grid{$ox,$oy}=~s/./O/ or die;
    #say "x: $x   y: $y   d: $d";
    my $is_loop=0;
    my %been;
    while( exists $grid{$x,$y} ) {
	last if $been{$x,$y,$d}++ and $is_loop=1;
	my($next,$dx,$dy)=@{$d{$d}};
	#$grid{$x,$y}=~s/[\.\^]/X/;
	$d=$next and ($next,$dx,$dy)=@{$d{$d}} while $grid{$x+$dx,$y+$dy}=~/[#O]/;
	$x+=$dx; $y+=$dy;
    }
    $loops += $is_loop;
    #if($loops){	for$x(0..$w-1){for$y(0..$w-1){print$grid{$x,$y}}print"\n"} exit }
}}

say "Answer: $loops";
#Answer: 1812 wrong    #3m45s
#Answer: 1811 wrong
#Answer: 

use Acme::Tools;
$\=$/; $/=$/.$/;
my$map=<>;
my@move=<>=~/./g;

print "Answer: <$map>";
print srlz(\@move,'move');
#my $x

my($x,$y,%grid)=(0,0); for($map=~/.*/g){ $grid{$x++,$y} = $_ for /./g; $w//=$x;$y++; $x=0 } #read input
print srlz(\%grid,'grid');
$map=~/@/;
my($x,$y)=(length($`)%($w+1),int(length($`)/($w+1)));
print"w: $w  pos: ".length($`)."   x: $x   y: $y\n";
my %dir=('<'=>[-1,0],'>'=>[1,0],'^'=>[0,-1],'v'=>[0,1]);
my %rot=('<'=>0,'>'=>2,'^'=>1,'v'=>3);
for my $move (@move){
    print"--------------- move: $move";
    $map=rotate_ccw($map)  for 1..$rot{$move};
#    $map=~s,\.\@,\@., or
    $map=~s,\.(O*)\@,$1\@.,;
    $map=rotate_cw($map)  for 1..$rot{$move};
    print ++$n,"/".@move;
}
my$sum=0;
$map=~s{O}{my($x,$y)=(length($`)%($w+1),int(length($`)/($w+1)));$sum+=$x+$y*100}ge;
print "Answer: $sum";
#.eval join '+', map {


sub rotate_ccw { my($i,@s);my$w=$_[0]=~/.*/?length$&:die;$i=$w,map$s[--$i].=$_,split// for split/\n/,pop;join"\n",@s } #counter clockwise
sub rotate_cw { my@l=reverse split/\n/,pop;my@r;my$i=0;while(length$l[0]){s/^.//,$r[$i].=$&for@l;$i++}join"\n",@r  } #clockwise

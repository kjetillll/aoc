use Acme::Tools; use List::Util qw(all any);

my $map;
while(<>){ last if !/\S/; $map.=$_ }
my @move=map{/./g}<>;

print "Answer: <$map>";
print srlz(\@move,'move');
#my $x
$map=~s/#/##/g;
$map=~s/O/\[\]/g;
$map=~s/\./../g;
$map=~s/\@/\@./g;
print$map;

my($x,$y,%grid)=(0,0,grid());
#die "w: $w   \n".srlz(\%grid,'grid','',1)=~s/$;/,/gr . $grid{10,3};

my($x,$y)=$map=~/@/ ? pos2xy($`) : die;
print"w: $w  pos: ".length($`)."   x: $x   y: $y\n"; #exit;

my %dir=('<'=>[-1,0],'>'=>[1,0],'^'=>[0,-1],'v'=>[0,1]);
my %rot=('<'=>0,'>'=>2,'^'=>1,'v'=>3);
#my@box;$map=~s{\[}{my($x,$y)=(length($`)%($w+1),int(length($`)/($w+1)));push$sum+=$x+$y*100}ge;

#$map=~s/\@\./.\@/ or die; @move=('<','<','<','<','<','<'); #case 1
#$map=~s/\.([\[\]]+)\@/\@$1./ or die; @move=('<','>','>','>','>','>','>','v'); #case 2
print"$map".("=" x 120)."\n";


for my $move (@move){
    %grid=grid();
    ($x,$y)=$map=~/@/ ? pos2xy($`) : die;
    print"--------------- move ".++$n."/".@move."   x: $x   y: $y   move: $move\n";
    my @m;
    if($move eq '<'){
	@m=lefts($x,$y);
	for(@m){
	    my($mx,$my,$mc)=@$_;
	    my$p=xy2pos($mx,$my);
	    substr($map,$p-1,1)=$mc;
	    substr($map,$p  ,1)='.';
	}
    }
    elsif($move eq '>'){
	@m=rights($x,$y);
	for(@m){
	    my($mx,$my,$mc)=@$_;
	    my$p=xy2pos($mx,$my);
	    substr($map,$p+1,1)=$mc;
	    substr($map,$p  ,1)='.';
	}
    }
    elsif($move eq '^'){
	@m=ups($x,$y);
	for(@m){
	    my($mx,$my,$mc)=@$_;
	    my$pu=xy2pos($mx,$my-1);
	    my$p=xy2pos($mx,$my);
	    substr($map,$pu,1)=$mc;
	    substr($map,$p  ,1)='.';
	}
    }
    elsif($move eq 'v'){
	@m=downs($x,$y);
	for(@m){
	    my($mx,$my,$mc)=@$_;
	    my$pd=xy2pos($mx,$my+1);
	    my$p=xy2pos($mx,$my);
	    substr($map,$pd,1)=$mc;
	    substr($map,$p  ,1)='.';
	}
    }
    print srlz(\@m,'move_now').$map;
}
my$sum=0;
$map=~s{[O\[]}{my($x,$y)=(length($`)%($w+1),int(length($`)/($w+1)));$sum+=$x+$y*100}ge;
print "Answer: $sum";
#.eval join '+', map {

sub lefts{
    my($x,$y)=@_;
    my @w=([$x,$y,$grid{$x,$y}]);
#    my @w=(left($x,$y) eq ']' ? [$x-1,$y,']'] : ());
    my %v;
    my @m;
    while(@w){
	my $w=shift@w;
	my($wx,$wy,$wc)=@$w;
	push @m, $w;
	push @w, [$wx-1,$wy,'['] if $wc eq ']';
	push @w, [$wx-1,$wy,']'] if left($wx,$wy) eq ']';
    }
    (any{left(@$_) eq '#'}@m) ? () : reverse@m
}

sub rights{
    my($x,$y)=@_;
    my @w=([$x,$y,$grid{$x,$y}]);
    my %v;
    my @m;
    while(@w){
	my $w=shift@w;
	my($wx,$wy,$wc)=@$w;
	push @m, $w;
	push @w, [$wx+1,$wy,']'] if $wc eq '[';
	push @w, [$wx+1,$wy,'['] if right($wx,$wy) eq '[';
    }
    (any{right(@$_) eq '#'}@m) ? () : reverse@m
}

sub ups{
    my($x,$y)=@_;
    my @w=([$x,$y,$grid{$x,$y}]);
    my %v;
    my @m;
    while(@w){
	my $w=shift@w;
	my($wx,$wy,$wc)=@$w;
	push @m, $w;
	push @w, [$wx,  $wy-1,'['],
	         [$wx+1,$wy-1,']'] if $grid{$wx,$wy-1} eq '[';
	push @w, [$wx,  $wy-1,']'],
	         [$wx-1,$wy-1,'['] if $grid{$wx,$wy-1} eq ']';
    }
    (any{up(@$_) eq '#'}@m) ? () : reverse@m
}


sub downs{
    my($x,$y)=@_;
    print "downs   x: $x   y: $y\n";
    my @w=([$x,$y,$grid{$x,$y}]);
    my %v;
    my @m;
    while(@w){
	print "downs work: ".srlz(\@w,'w');
	my $w=shift@w;
	my($wx,$wy,$wc)=@$w;
	push @m, $w;
	push @w, [$wx,  $wy+1,'['],
	         [$wx+1,$wy+1,']'] if $grid{$wx,$wy+1} eq '[';
	push @w, [$wx,  $wy+1,']'],
	         [$wx-1,$wy+1,'['] if $grid{$wx,$wy+1} eq ']';
    }
    (any{down(@$_) eq '#'}@m) ? () : reverse@m
}


sub rotate_ccw { my($i,@s);my$w=$_[0]=~/.*/?length$&:die;$i=$w,map$s[--$i].=$_,split// for split/\n/,pop;join"\n",@s } #counter clockwise
sub rotate_cw { my@l=reverse split/\n/,pop;my@r;my$i=0;while(length$l[0]){s/^.//,$r[$i].=$&for@l;$i++}join"\n",@r  } #clockwise
sub pos2xy{my$p=pop;$p=length$p if$p!~/^\d+$/;($p%($w+1),int($p/($w+1)))}
sub xy2pos{my($x,$y)=@_;$x+$y*($w+1)}
sub left {my($x,$y)=@_;$grid{$x-1,$y}}
sub right{my($x,$y)=@_;$grid{$x+1,$y}}
sub up   {my($x,$y)=@_;$grid{$x,$y-1}}
sub down {my($x,$y)=@_;$grid{$x,$y+1}}
sub grid{
    my($x,$y,%grid)=(0,0);
    for my $l ($map=~/.+/g){$grid{$x++,$y} = $_ for $l=~/./g; $w//=$x;$y++; $x=0 };
    %grid;
}

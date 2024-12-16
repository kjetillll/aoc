#use strict; use warnings;
use v5.10; use List::Util qw(all sum min max); use Acme::Tools qw(ansicolor);
use Tie::Array::Sorted; # sudo apt install libtie-array-sorted-perl
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
($x,$y)=(grep{$grid{$_}eq'S'}keys%grid)[0]=~/\d+/g;
my %dir=(
    E=>[1,0,'N','S'],
    N=>[0,-1,'W','E'],
    W=>[-1,0,'S','N'],
    S=>[0,1, 'E','W'],
    );
my $w=max(map/^\d+/?1+$&:die,keys%grid);
my $h=max(map/\d+$/?1+$&:die,keys%grid);
my $dir='E';
my @w; tie @w, "Tie::Array::Sorted", sub { $_[0] cmp $_[1] };
push @w, info(0,$x,$y,$dir);
while(@w){
    my $w=shift@w;
    my($wscore,$wx,$wy,$wdir)=map s/^0+//r,split/,/,$w;
    #say "wscore: $wscore   wx: $wx   wy: $wy   wdir: $wdir";
    next if $wscore > ($max{$wx,$wy,$wdir}//9e9);
    next if $grid{$wx,$wy} eq '#'; #unødv?
    last if $grid{$wx,$wy} eq 'E' and say"Answer: $wscore";
    $max{$wx,$wy,$wdir}=$wscore;
    #print "w size: ".@w."\r";
    my @dir = ($wdir,$dir{$wdir}[2,3]);
    for($wdir,@{$dir{$wdir}}[2,3]){
	my($nx,$ny)=($wx+$dir{$_}[0],$wy+$dir{$_}[1]);
	next if $grid{$nx,$ny} eq '#';
	my $nscore = $wscore + ($_ eq $wdir ? 1 : 1001);
	push @w, info($nscore, $nx, $ny, $_);
    }
}
say "start   x: $x   y: $y   w: $w   h: $h";
sub info{my($score,$x,$y,$dir)=@_; sprintf("%08d,%04d,%04d,%1s",$score,$x,$y,$dir)}

# time perl 2024_day_16_part_1.pl 2024_day_16_input.txt  # 0.99 sec
# Answer: 108504

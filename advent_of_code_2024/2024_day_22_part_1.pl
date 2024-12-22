#./getinp.pl
#use strict; use warnings; no warnings 'recursion';
use v5.10;
use Acme::Tools qw(srlz ansicolor cart);
use List::Util qw(min max first all any sum uniq);
use Algorithm::Combinatorics qw(permutations subsets);
use Math::Matrix;
use Math::Prime::Util::GMP qw(divisors sigma);
use Storable qw(dclone);
use Time::HiRes qw(time);
use Test::More;
use List::BinarySearch::XS qw(binsearch_pos);
use Tie::Array::Sorted; #PP!
use Getopt::Std; my %opt; getopts('v:',\%opt);
use Carp;
sub deb($){print$ENV{DEBUG}?"$_[0]\n":""}

my @inp = <>;

for my $inp (@inp){
    my$secret=$inp;
    for(1..2000){
	my $m = $secret*64;
	$secret ^= $m;
	$secret %= 16777216;
	#    say $secret;
	
	my $d = int($secret/32);
	$secret ^=$d;
	$secret %= 16777216;
	#    say $secret;
	
	$m = $secret*2048;
	$secret ^= $m;
	$secret %= 16777216;
	#    say $secret;
    }
    say"$inp: $secret";
    $ans+=$secret;
}
say"Answer: $ans";
exit;
__END__

#my @inp = <>;
#say "input lines: ".@inp;
#say "input line avg length: ".(sum(map length,@inp)/@inp);
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
my @x=sort{$a<=>$b}uniq(map/^\d+/?$&:die,keys%grid);
my @y=sort{$a<=>$b}uniq(map/\d+$/?$&:die,keys%grid);
my($w,$h)=(0+@x,0+@y);
sub showgrid{for$y(@y){for$x(@x){print$grid{$x,$y}//'_'}print"\n"}}
my @dir = ([1,0],[0,1],[-1,0],[0,-1]);
my @dir3x3 = ([-1,-1],[0,-1],[1,-1],
              [-1,0],[0,0],[1,0],
              [-1,1],[0,1],[1,1]); #@dir3x3=cart( ([-1,0,1]) x 2 )
my@work=([]);
while(@work){
    my($wx,$wy,$step)=@{shift@work};
    next if $seen{$wx,$wy,$step}++;
    #push@work,[,,$step+1]...
}

my $pos = binsearch_pos {$$b[0]<=>$$a[0] || $$a[1]<=>$$b[1]} $new_work, @work;
splice@work,$pos,0,$new_work;

sub rotate_ccw { my($i,@s);my$w=$_[0]=~/.*/?length$&:die;$i=$w,map$s[--$i].=$_,split// for split/\n/,pop;join"\n",@s } #counter clockwise
sub rotate_cw { my@l=reverse split/\n/,pop;my@r;my$i=0;while(length$l[0]){s/^.//,$r[$i].=$&for@l;$i++}join"\n",@r  } #clockwise
sub freq{my%f;@f{$_}++for@_;%f}
# time perl 2024_day_??_part_?.pl 2024_day_??_example.txt
# time perl 2024_day_??_part_?.pl 2024_day_??_input.txt       # ?.?? sec
# Answer: ....

# cilmd *pl *txt; for d in {20..25};do cp -p prep.pl 2024_day_${d}_part_1.pl;  cp -p prep.pl 2024_day_${d}_part_2.pl; done

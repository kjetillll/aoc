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



#my @inp = <>;
#say "input lines: ".@inp;
#say "input line avg length: ".(sum(map length,@inp)/@inp);
my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
my @x=sort{$a<=>$b}uniq(map/^\d+/?$&:die,keys%grid);
my @y=sort{$a<=>$b}uniq(map/\d+$/?$&:die,keys%grid);
my($w,$h)=(0+@x,0+@y);
showgrid();
my($sx,$sy)=(grep$grid{$_} eq 'S',keys%grid)[0]=~/\d+/g;
my($ex,$ey)=(grep$grid{$_} eq 'E',keys%grid)[0]=~/\d+/g;
say"sx: $sx   sy: $sy   ex: $ex   ey: $ey";
sub showgrid{my%gr=@_?@_:%grid;for$y(@y){for$x(@x){print$gr{$x,$y}//'_'}print"\n"}1}
my @dir = ([1,0],[0,1],[-1,0],[0,-1]);
my @dir3x3 = ([-1,-1],[0,-1],[1,-1],
              [-1,0],[0,0],[1,0],
              [-1,1],[0,1],[1,1]); #@dir3x3=cart( ([-1,0,1]) x 2 )

my($step,%run)=mazerun(1);
#my %ch;
for(keys%run){
    my($x,$y)=/\d+/g;
    for(@dir){
	my($gx,$gy) = ($x +   $$_[0], $y +   $$_[1]);
	my($rx,$ry) = ($x + 2*$$_[0], $y + 2*$$_[1]);
	$ch{$gx,$gy}='C' if $grid{$gx,$gy} eq '#' and $run{$rx,$ry};
    }
}
show(\%grid,\%run);


my @ch=keys%ch;
my %org=%grid;



#todo: replace loop with counting in %steps how many steps that cheat is causing
for(0..$#ch){
    print "cheat no $_ of ".@ch."\r";
#    last if $_>200;
    %grid = %org;
    $grid{$ch[$_]}=~s/\#/./ or die;
    #say "keys grid: ".keys(%grid)."   keys org: ".keys(%org);exit;
    my($step_now)=mazerun(0);
#    die"<$step_now>";
    my$save=$step-$step_now;
    next if!$save;
    push @cheats,$save;
}
say "mazerun, steps: $step   runlen: ".keys(%run)."   cheat posibilities: ".keys%ch;

my %c = freq(@cheats);
print srlz(\@cheats,'cheats');
print srlz(\%c,'c');
print "There are $c{$_} cheats that save $_ picoseconds.\n" for sort{$a<=>$b}keys%c;
for my $limit (1, 100){
    my $ans=0; $_>=$limit and $ans += $c{$_} for sort{$a<=>$b}keys%c;
    say "Answer: $ans cheats saves at least $limit picoseconds";
}

sub mazerun {
    my $return_run=shift;
    my @work=([$sx,$sy,0,0]);
    my %steps;
    my %stepsc;
    while(@work){
	my($wx,$wy,$step,$cheats_left,$run)=@{shift@work};
	my $g=$grid{$wx,$wy};
	next if !defined$g;
	next if $g eq '#';
	#	next if $g eq 'E' and say"Reached E, steps: $step" and fix(\%grid,\%run) and print srlz({map s/$;/,/gr,%run},'b') and push@end,$step;
	$run.=" $wx$;$wy";
	return ($step,map{$_=>1}split/ /,$run) if $g eq 'E' or $step>9922 and say"#work: ".@work;
	next if  $step >= ($steps{$wx,$wy}//9e9);
	$steps{$wx,$wy}=$step;
	if($return_run){ push@work,map [ $wx+$$_[0], $wy+$$_[1], $step+1, $cheats, $run ], @dir }
	else           { push@work,map [ $wx+$$_[0], $wy+$$_[1], $step+1, $cheats       ], @dir }
    }
}


sub freq{my%f;@f{$_}++for@_;%f}
sub show{
    my($gr,$be)=@_;
    my%g=%grid;
    $g{$_}=~s/./ansicolor("¤b$&¤¤")/eg for keys%ch;
    $g{$_}=~s/\./ansicolor("¤g*¤¤")/eg for keys%$be;
    $g{$_}=~s/\#/ansicolor("¤rC¤¤")/eg for keys%$be;
    showgrid(%g);
    say"end: @end   count: ".@end;
    1;
}


__END__
my $pos = binsearch_pos {$$b[0]<=>$$a[0] || $$a[1]<=>$$b[1]} $new_work, @work;
splice@work,$pos,0,$new_work;

sub rotate_ccw { my($i,@s);my$w=$_[0]=~/.*/?length$&:die;$i=$w,map$s[--$i].=$_,split// for split/\n/,pop;join"\n",@s } #counter clockwise
sub rotate_cw { my@l=reverse split/\n/,pop;my@r;my$i=0;while(length$l[0]){s/^.//,$r[$i].=$&for@l;$i++}join"\n",@r  } #clockwise
# time perl 2024_day_??_part_?.pl 2024_day_??_example.txt
# time perl 2024_day_??_part_?.pl 2024_day_??_input.txt       # ?.?? sec
# Answer: ....

# cilmd *pl *txt; for d in {20..25};do cp -p prep.pl 2024_day_${d}_part_1.pl;  cp -p prep.pl 2024_day_${d}_part_2.pl; done

wo cheating 9432?

mazerun, steps: 84   cheat posibilities: 44    #example

mazerun, steps: 9432   cheat posibilities: 6943 #input 22s
mazerun, steps: 9432   cheat posibilities: 6943 #input 0.5s beenstr


Answer: 1518 cheats saves at least 100 picoseconds  

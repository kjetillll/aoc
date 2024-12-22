#./getinp.pl
#use strict; use warnings; no warnings 'recursion';
use v5.10;
use Acme::Tools qw(srlz ansicolor cart btw);
use List::Util qw(min max first all any sum uniq shuffle);
use Algorithm::Combinatorics qw(permutations subsets);
use Math::Matrix;
use Math::Prime::Util::GMP qw(divisors sigma);
use Storable qw(dclone);
use Time::HiRes qw(time);
#use Test::More;
use List::BinarySearch::XS qw(binsearch_pos);
use Tie::Array::Sorted; #PP!
use Getopt::Std; my %opt; getopts('v:',\%opt);
use Carp;
sub deb($){print$ENV{DEBUG}?"$_[0]\n":""}

sub nxt($) {
    my $s=shift;
    $s^=$s<<6;
    $s%=16777216;
    $s^=$s>>5;
    $s%=16777216;
    $s^=$s<<11;
    $s%=16777216;
    $s;
}
#say "$_ ".nxt($_) for 2523205, 11455885, 39867, 1165008, 15286598;say"";
#say "$_ ".nxt($_) for 10136384, 16066714, 632426, 9131277, 7020287;say"";
#say "$_ ".nxt($_) for 13534020, 7049430, 4733052, 16133703, 15567483;say"";
#say "$_ ".nxt($_) for 8950534, 2727954, 924086, 3182487, 10213637;say"";exit;


#$cc{nxt($_)}++ for(0..16777215);
#say 0+keys%cc;
#say min keys%cc;
#say max keys%cc;
#
#say nxt$_ for 123..123;
#say nxt nxt nxt nxt nxt nxt nxt nxt nxt nxt$_ for 123..124;


my @inp = map s,\n,,r, <>;

my @ss=cart(([-9..9])x4);

our $count=0;
my $max=0;
my @w=@ss;
#my @w=shuffle@ss;

@w = map$$_[0],sort{$$a[1]<=>$$b[1]}map[$_,sum(map abs($_),@$_)],@w; #@w=@w[0..10]; die srlz(\@w,'w','',1);
#my @w=@ss;
while(@w){
    my @seq = @{shift@w};
    #next if "@seq" ne "-2 1 -1 3"; #Ans:23 (example2)  Ans:1476(input)
    #next if "@seq" ne "1 1 1 1";
    next if $count>=1 and !$d{"@seq"};
#    next if $count>=3 and "@sec" ne '0 2 1 0';
    my $b=bananas(@seq);
   #my $b=btw($count,3,500)?-1:bananas(@seq);
    $max=$b if $b>$max;
    say "".++$count."/".@w."  ban: $b   max so far: $max     diffs: ".keys(%d)."   seq: @seq   ";
    if($count==2){
	@w=grep{$d{"@$_"}}@w;
	#printf"%d  %05b   %d  %05b   %d  %05b   %d  %05b   \n",$$_[0],$$_[0],$$_[1],$$_[1],$$_[2],$$_[2],$$_[3],$$_[3],$$_[4],$$_[4] for map[/\S+/g],sort keys%d;exit;
    }
#    last if "@sec" eq '0 2 1 0';
#    last if $count==5;
}
say "Answer: $max";
		  
#Answer: 861    too low
#Answer: 1639   too low
#Answer: 1851   not right
#Answer: 1915   not right
#Answer: 1995   not right

sub bananas {
    my @seq=@_;
    my $seq="@seq";
    my $bananas=0;
    #say"seq: $seq";
    my $cb=0;
  INP:
    for my $inp (@inp){
	#say"inp: $inp";
	my$secret=$inp;
	my @secret;
	push@secret,$secret;
	while(@secret<2000){
	    $secret ^= $secret*64;
	    $secret %= 16777216;
	    #    say $secret;
	    
	    $secret ^=$secret>>5;
	    $secret %= 16777216;
	    #    say $secret;
	    
	    $secret ^= $secret<<11;
	    $secret %= 16777216;
	    #    say $secret;
	    push @secret,$secret;
	    
	    my $one=$secret%10;
	    push @diff, $one-$p if defined$p;
	    $p=$one;
	    shift@diff if @diff>4;
	    $d{"@diff"}++ if $count<10;#hm
	    #$dd{"@diff"}
	    #printf "inp: $inp  #".@secret." secret: %8d   one: $one   secbin: %026b   diff: @diff   s: @seq\n", $secret, $secret;
	    if( "@diff" eq $seq){
		$bananas+=$one;
		if($seq eq '0 2 1 0'){
		    printf "inp: $inp  #".@secret." secret: %8d   one: $one   secbin: %026b   b: $bananas   diff: @diff   s: @seq\n", $secret, $secret;
		    print join(", ",@secret[-5,-4,-3,-2,-1]),"\n";
		}
		#say "inp $inp   price $one" ;
		#exit if ++$cb==5;
#		next INP
	    }
	}
    }
    $bananas
}


#    my $p;
#    for(@s){
#	my $diff=defined$p?$_%10-$p:'';
#	printf"%11d: %d (%s)\n",$_,$_%10,$diff;
#	$p=$_%10;
#    }
#    last
#    say"$inp: $secret";
    #    $ans+=$secret;
    
#say"Answer: $ans";
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

use v5.10;
use Acme::Tools qw(srlz ansicolor cart brex);
use List::Util qw(min max first all any sum uniq);
use Algorithm::Combinatorics qw(permutations subsets);
use List::BinarySearch::XS qw(binsearch_pos);

my @inp = map s,\n,,r, <>; #@inp=('');
my %num=(  A => [2,3],  0 => [1,3],  1 => [0,2],  2 => [1,2],  3 => [2,2],  4 => [0,1],  5 => [1,1],  6 => [2,1],  7 => [0,0],  8 => [1,0],  9 => [2,0], avoid => qr/^(1v|4vv|7vvv|0<|A<<)/ );
my %dir=(  A => [2,0], '^'=> [1,0], '<'=> [0,1], 'v'=> [1,1], '>'=> [2,1], avoid => qr/^(\^<|<\^|A<<)/ );

#@inp = ('029A');
my $ans = 0;
my $minlen;
$|=1;
for my $inp (@inp){


    my $min=9e9;
    my(%min,%max,$maxr);
    my $tr=0;
    my $minprev;
    my @work=([$inp,1,length($inp)]);
    while(@work){
	my($p,$r,$l,$lu,$prev,$pp)=@{shift@work};
	#	next if $l>$min;
	$min{$r}=$l if $l<$min{$r} or !exists$min{$r};
	$max{$r}=$l if $l>$max{$r} or !exists$max{$r};
	$maxr=$r if $r>$maxr;
	printf "work count: %7d   r: $r   maxr: $maxr   l: $l   min-max  ".join("   ",map"$_: $min{$_}-$max{$_}",1..5)."      \r",0+@work,$min;
#	last if $r==5;
	if($r==4){
	    if($l<$min){
		($min,$minp,$minprev,$minpp)=($l,$p,$prev,$pp) if $l<$min;
#		say "inp: $inp   p: $p   r: $r   l: $l   min: $min   work: ".@work;
		@work = grep$$_[2]<=$min,@work;
		#		say "inp: $inp   p: $p   r: $r   l: $l   min: $min   work: ".@work;
#		last;
	    }
#	    print"\n";
#	    last;
	}
	else{
	    for(seq($p,$r==1?\%num:\%dir)){
		my $u=$_; $u=~s/(.)\1+/$1/g;
		my $new=[$_,$r+1,length($_),length($u),$p,$prev];
	        my $pos=binsearch_pos {$$b[1]<=>$$a[1] || $$a[3]<=>$$b[3] || $$a[2]<=>$$b[2]} $new, @work;
	       #my $pos=binsearch_pos {                   $$a[2]<=>$$b[2]} $new, @work;
		splice@work,$pos,0,$new;
	    }
	}
    }
    
    print"\n";
    
    say "                                        prev: $minpp";
    say "                                        prev: $minprev";
    say "trinn3: seq count:".@seq."   seq min len: $min   minp: $minp";

    my $numpart = $inp=~s/\D//gr=~s/^0+//gr;
    $ans += $min * $numpart;
}
say "Answer: $ans";

sub seq {
    my($want,$kbd,$deb)=@_;
    my @k = "A$want" =~ /./g;
    #print srlz(\@k,'k');
    my $g='';
    for(0 .. $#k-1){
	my($f,$t)=@k[$_,$_+1];
	my $str=str($f,$t,$kbd,$_?substr($strf,-1,1):undef);
	$g .= $str;
	$strf=$str;
    }
    #say "$_: ".join("   ",brex($str));
    my @r=glob($g);
    print"...$deb seq ret len: ".@r."\n" if @_>2;
    @r
}

sub str {
    my($f,$t,$kbd,$strf)=@_;
    $memo{$f,$t,$kbd,$strf} //= do{
	die"<$f>  <$t>" if !exists$$kbd{$f} or !exists$$kbd{$t};
	my($dx,$dy)=map $$kbd{$t}[$_]-$$kbd{$f}[$_],0,1;
	my $x='>'x$dx.'<'x-$dx;
	my $y='v'x$dy.'^'x-$dy;
	my @p = grep { "$f$_" !~ $$kbd{avoid} } uniq "$y$x", "$x$y";
	#@p=($p[-1]) if defined($strf) and substr($p[0],0,1) eq $strf and die;
	#uniq map join("",@$_), permutations([ ('>') x $dx, ('<') x -$dx, ('v') x $dy, ('^') x -$dy ]);
	"" . ( @p==1 ? $p[0] : "{".join(",",@p)."}" ) . "A";
    }
}

__END__


Answer: 278568


                                        prev:   v <<   A >  ^ AA > A  v <<   A >>  ^ A  v  A   <   AA >  ^ A  v  A ^ A
trinn3: seq count:0   seq min len: 72   minp: <vA<AA>>^AvA<^A>AAvA^A<vA<AA>>^AvAA<^A>A<vA>^Av<<A>>^AAvA<^A>A<vA>^A<A>A

a(xy,22) == a(?,23)+a(?,23)

a(Av,24) == 3
a(v<,24) == 2
a(<<,24) == 1



                                        prev:          <      ^^   A         <       A     >       vv      A     >   A
                                        prev:   v <<   A >  ^ AA > A  v <<   A >>  ^ A  v  A   <   AA >  ^ A  v  A ^ A
trinn3: seq count:0   seq min len: 72   minp: <vA<AA>>^AvA<^A>AAvA^A<vA<AA>>^AvAA<^A>A<vA>^Av<<A>>^AAvA<^A>A<vA>^A<A>A

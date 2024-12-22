use v5.10; use List::Util qw(sum);
my @inp = map s,\n,,r,<>;
my %secrets;
my %diffs;
for my $inp (@inp){
    my $sec=$secrets{$inp}=[];
    my $dif=$diffs{$inp}=[];
    my $s=$inp;
    do { push @$sec, $s;
	 $s^=$s<<6;
	 $s%=16777216;
	 $s^=$s>>5;
	 $s%=16777216;
	 $s^=$s<<11;
	 $s%=16777216;
	 $s;
	 push @$dif, @$sec>1 ? $$sec[-1]%10 - $$sec[-2]%10 : undef;
	 if(@$dif>4){ $seqok{"@$dif[-4,-3,-2,-1]"}++}
    } until @$sec==2001;
}
say "count seqok: ".keys(%seqok); #die srlz(\%seqok,'seqok','',1);
my($start,$count,$max,$maxseq)=(time(),0,0,'');
my @w = map $$_[0],
        sort{$$a[1]<=>$$b[1]}
        map[$_,sum(map abs($_),@$_)],  #smart sortering?
        grep{$seqok{"@$_"}}
        cart(([-9..9])x4);
for my $seq (@w){
    $count++;
    my @seq = @$seq;
    my $ban=0;
    next if !$seqok{"@seq"};
    INP:
    for my $inp (@inp){
	my $dif=$diffs{$inp};
	#my $store = !exists $is{$inp,$seq[3]};
	#my @is = $store ? (4..$#$dif) : @{$is{$inp,$seq[3]}};
	#my @is = 4..$#$dif;
	#say "is: ".@is;
	for my $i (4..$#$dif){
	    #push @{$is{$inp,$seq[3]}},$i if $store;
	    if(  $$dif[$i]  ==$seq[3]
	    &&   $$dif[$i-1]==$seq[2]
	    &&   $$dif[$i-2]==$seq[1]
	    &&   $$dif[$i-3]==$seq[0]
	    ){
		$ban += $secrets{$inp}[$i] % 10;
		#say"...$inp: ... ",$secrets{$inp}[$i-$_],   "   b: $b   ban: $ban" for 4,3,2,1,0;
		next INP;
	    }
	}
    }
    ($max,$maxseq) = ($ban,"@seq") if $ban>$max;
    printf "%d/%d %d  seq: %-20s   ban: %4d   max: %4d   max seq: %-20s   keys is: %d\n", $count,0+@w,time()-$start,"@seq",$ban,$max,$maxseq,0+keys(%is);
}
sub cart {
  my @ars=@_;
  my @res=map[$_],@{shift@ars};
  for my $ar (@ars){
    @res=grep{&$ar(@$_)}@res and next if ref($ar) eq 'CODE';
    @res=map{my$r=$_;map{[@$r,$_]}@$ar}@res;
  }
  @res;
}

say "Answer: $max";

#Answer: 1998        funnet etter ca 110sek, men kunne ikke vite om det var max

#print srlz(\%secrets,'secrets','',1);

#130321/130321   seq: 9 9 9 9                ban:    0   max:   23   max seq: -2 1 -1 3              keys is: 1444    #    1m20s
    

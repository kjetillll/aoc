use v5.10;
use List::Util qw(sum min);
use Algorithm::Combinatorics 'subsets';

my @p = sort {$b<=>$a} map/\d+/g,<>; #descending input

my $w = sum @p;
my $wg = $w / 4; #weight group

say "count: ".@p."   w: $w   wg: $wg   p: @p";

my $n=0;
for my $size (1..@p-2){
    my @QE;
    my $iter = subsets(\@p,$size);
    while(my $group1 = $iter->next){
	my $wgroup1=sum @$group1;
	next if $wgroup1 != $wg;        #skip unless right weight
	my $QE = eval join '*', @$group1;
	say "n: ".++$n."   size: $size   group1: @$group1   QE: $QE";
	my %group1; @group1{@$group1}=();
	my @rest = grep !exists $group1{$_}, @p;
	my $group2_exists = 0; #1=assumes there's always a way to part @rest with right weight without actually checking (for speedup)
	my $iter2=subsets(\@rest);
	while(!$group2_exists and my $group2 = $iter2->next){ #check if group2 can be found for this group1
	    $group2_exists=1 if $wg == sum @$group2;
	}
	push @QE, $QE if $group2_exists;
    }
    last if @QE and say "Answer: ", min @QE;
}

#time perl 2015_day_24_part_2.pl 2015_day_24_input.txt  #1.26 sec with descending input and no group2_exists assumption

#Answer: 80393059

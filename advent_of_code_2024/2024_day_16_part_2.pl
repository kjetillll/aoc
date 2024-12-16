use v5.10; use List::Util qw(uniq); use strict; use warnings;
use List::BinarySearch::XS qw(binsearch_pos);
#use Tie::Array::Sorted; 
my($x,$y,%grid) = (0, 0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
my %dir = ( E => [1,0,  'N', 'S'],
            N => [0,-1, 'W', 'E'],
            W => [-1,0, 'S', 'N'],
            S => [0,1,  'E', 'W'] );
my($best, @bestpaths, %max) = (9e9);
#tie my @work, "Tie::Array::Sorted", sub { $_[0] cmp $_[1] }; #keep sorted
my @work;
push @work, do{
    my($x,$y) = ( grep $grid{$_} eq 'S', keys %grid )[0] =~ /\d+/g;
    workinfo(0, $x, $y, 'E', "$x;$y") #start
};
while(@work){ #bfs, or rather: score-first-search
    my($wscore,$wx,$wy,$wdir,$wpath) = split /,/, shift @work;
    next if $wscore > ( $max{$wx,$wy,$wdir} // 9e9 );
    last if $wscore > $best;
    $max{$wx,$wy,$wdir} = $wscore;
    next if $grid{$wx,$wy} eq 'E' and do{ $best = $wscore; push@bestpaths,$wpath};
    for my $d ($wdir, @{$dir{$wdir}}[2,3]){
        my($nx, $ny) = ( $wx + $dir{$d}[0],
                         $wy + $dir{$d}[1] );
        next if $grid{$nx,$ny} eq '#';
        my $nscore = $wscore + ($d eq $wdir ? 1 : 1001);
	my $wi = workinfo($nscore, $nx, $ny, $d, $wpath."_"."$nx;$ny");
	my $pos = binsearch_pos {$a cmp $b} $wi, @work;
        splice @work, $pos, 0, $wi; #keep sorted
    }
}
say "number of bestpaths: ".@bestpaths;
say "Answer: ".uniq( map {split/_/} @bestpaths );

sub workinfo{sprintf("%09d,",shift@_).join',',@_}

# Run:   time perl 2024_day_16_part_2.pl 2024_day_16_input.txt    # 0.61 sek List::BinarySearch (::XS, C/C++ based)
# Run:   time perl 2024_day_16_part_2.pl 2024_day_16_input.txt    # 1.10 sek Tie::Array::Sorted (pure perl thus slower)
# number of bestpaths: 24
# Answer: 538

use strict; use warnings; use v5.10; use List::Util qw(min max uniq shuffle);
my @p = map [ /\d+/g ], <>;
say "p: ".@p."   uniq x: ".uniq(map$$_[0],@p)."   uniq y: ".uniq(map$$_[1],@p);
my $i=0;
my %mx = map { $_ => ++$i } sort {$a<=>$b} uniq map $$_[0], @p; $i=0;
my %my = map { $_ => ++$i } sort {$a<=>$b} uniq map $$_[1], @p;
@p = map [$mx{$$_[0]}, $my{$$_[1]}], @p;  #convert to a quicker smaller world with only enumed uniq coords
my %xm = reverse %mx; #for converting back later when calculating area
my %ym = reverse %my;
my %p = map { join($;, @$_) => '#' } @p; #grid

#----draw lines between @p points
for( 0 .. $#p ){
    my($x,  $y)  = @{ $p[$_]          };
    my($nx, $ny) = @{ $p[($_+1) % @p] }; #next point
    if   ( $x == $nx ){ $p{$x,$_} = 'X' for min($y,$ny)+1 .. max($y,$ny)-1 }
    elsif ($y == $ny ){ $p{$_,$y} = 'X' for min($x,$nx)+1 .. max($x,$nx)-1 }
    else{die} #assume only horisontal and vertical lines
}

#---- paint inside
my $maxx = max map$$_[0], @p;
my $maxy = max map$$_[1], @p;
my $pt = 0;
TRIAL:
while(1){
    $pt++; #paint trials
    my @q = ( [int(1+rand($maxx)),    #random x and y
               int(1+rand($maxy))] );
    my %pp;
    while(@q){
        my($qx, $qy) = @{ shift @q };
        next TRIAL unless 1 <= $qx <= $maxx;
        next TRIAL unless 1 <= $qy <= $maxy;
        next if exists $p{$qx,$qy};
        next if exists $pp{$qx,$qy};
        $pp{$qx,$qy} = 'o';
        push @q, [$qx-1,$qy], [$qx+1,$qy], [$qx,$qy-1], [$qx,$qy+1];
    }
    %p = (%p, %pp);
    last;
}
if( $ENV{VERBOSE} ){
  for my $y (1..max(map$$_[1],@p)){
  for my $x (1..max(map$$_[0],@p)){
    print $p{$x,$y} // '.';
  } print "\n"}
}
say "paint trails: $pt";

#---- check all pairs of #points
my $max_area = -1;
my $t = 0;
my $next = 0;
@p = shuffle @p;  #speedup ~10%
for my $p1 (@p){P:
for my $p2 (@p){
    my($x1, $x2) = ($$p1[0], $$p2[0]);
    my($y1, $y2) = ($$p1[1], $$p2[1]);
    next if $x1 > $x2;
    ($y1, $y2) = ($y2, $y1) if $y1 > $y2;
    print "t: ".++$t." / ".(@p**2)."   max_area: $max_area   next: $next\r" if $ENV{VERBOSE};
    my $area = ( $xm{$x2} - $xm{$x1} + 1 ) #convert back to the real coordinates
             * ( $ym{$y2} - $ym{$y1} + 1 );
    next if $area <= $max_area and ++$next;
    for my $ay ($y1 .. $y2){
    for my $ax ($x1 .. $x2){ next P if !exists $p{$ax, $ay} }} #area not all colored
    $max_area = $area;
    say "max area so far: $max_area";
}}
say "Answer: $max_area";


# perl 2025_day_09_part_2.pl 2025_day_09_example.txt
# Answer: 24

# perl 2025_day_09_part_2.pl 2025_day_09_input.txt     # 8.1 seconds
# Answer: 1543501936

#todo:
#speedup?: shoelace or x-ray algorithms to chech if area is inside?
#speedup!: register instead of 'o' how many x's can be skipped ahead because they are all painted, probably huge speedup

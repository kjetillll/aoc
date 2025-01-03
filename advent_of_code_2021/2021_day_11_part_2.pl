use strict; use warnings; use v5.10; use List::Util qw(uniq);

my($x,$y,%grid)=(0,0); while(<>){ $grid{$x++,$y} = $_ for /./g; $y++; $x=0 } #read input
my @x=sort{$a<=>$b}uniq(map/^\d+/?$&:die,keys%grid);
my @y=sort{$a<=>$b}uniq(map/\d+$/?$&:die,keys%grid);
my @neig = ([-1,-1],[0,-1],[1,-1],
            [-1,0],      [1,0],
            [-1,1],[0,1],[1,1]);

sub showgrid($){$ENV{DEBUG}||return;say"\n$_[0]";for$y(@y){for$x(@x){print$grid{$x,$y}//'_'}say''}}

showgrid "Before any steps:";

my $answer = 0;
for my $step ( 1 .. 9e9 ){
    $grid{$_}++ for keys %grid;
    my %flashes;
    my $nflash = sub {my($x,$y)="@_"=~/\d+/g; 0 + grep $flashes{$x+$$_[0],$y+$$_[1]}, @neig };
    my @f; @flashes{@f}=(1)x@f while @f = grep !$flashes{$_} && $grid{$_} + $nflash->($_) > 9, keys %grid;
    $grid{$_} += $nflash->($_) for keys%grid;
    $grid{$_} = 0 for grep $grid{$_} > 9, keys %grid;
    showgrid "After step $step:";
    say "Answer: $step" and last if keys(%flashes) == keys(%grid);
}

# time perl 2021_day_11_part_2.pl 2021_day_11_input.txt        # 0.24 sec
# Answer: 251

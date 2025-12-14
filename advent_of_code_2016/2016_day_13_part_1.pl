use v5.10; use strict; use warnings;

my $goal = $ARGV[0] =~ /example/ ? "7,4" : "31,39";
my $fav_num = 0 + <>;
my %visited;
my @w = ( {step=>0, x=>1, y=>1} );
while(@w){ #while work to be done, places to go...
    my %w = %{ shift @w };
    say "Answer: ".keys(%visited) and last if $0 =~ /part_2/ and $w{step} == 50+1;
    next if $visited{$w{x},$w{y}}++;
    say "work todo: ".@w."   step: $w{step}   x: $w{x}   y: $w{y}" if $ENV{VERBOSE};
    say "Answer: $w{step}" and last if "$w{x},$w{y}" eq $goal;
    push @w,
        grep !is_wall( $$_{x}, $$_{y} ),
        grep $$_{x} >= 0,
        grep $$_{y} >= 0,
        map { {step=>$w{step}+1, x=>$w{x}+$$_[0], y=>$w{y}+$$_[1]} }
        [-1,0],[1,0],[0,-1],[0,1];
}
sub is_wall {
    my($x,$y)=@_;
    my $n = $x*$x + 3*$x + 2*$x*$y + $y + $y*$y + $fav_num;
    length(sprintf('%b', $n) =~ s/0//gr) % 2
}

# perl 2016_day_13_part_1.pl 2016_day_13_example.txt
# Answer: 11

# perl 2016_day_13_part_1.pl 2016_day_13_input.txt      #0.04 seconds
# Answer: 96

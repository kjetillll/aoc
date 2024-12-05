use strict; use warnings; use List::Util qw(sum min max); sub deb($){print$ENV{DEBUG}?"$_[0]\n":""}

my(%item,$type);
while(<DATA>){
    $type = $1 if /(\w+?)s?:/;
    push @{ $item{$type} }, {name=>$1, cost=>$2, damage=>$3, armor=>$4} if /(.*?) +(\d+) +(\d+) +(\d+)/;
}

printf "answer example: %s\n", winner( player => {hit=>8, damage=>5, armor=>5},
				       boss   => {hit=>12, damage=>7, armor=>2} );
my %boss_input = map { /^(\w+).*?(\d+)$/; (lc$1=>$2)} <>;
my @lose_cost;
my $game = 0;
for my $w  (              @{ $item{Weapon} } ){
for my $a  ( {name=>'-'}, @{ $item{Armor}  } ){
for my $r1 ( {name=>'-'}, @{ $item{Ring}   } ){
for my $r2 ( {name=>'-'}, @{ $item{Ring}   } ){
    next if $$r1{name} eq $$r2{name}; #"can't buy, for example, two rings of Damage +3"
    deb "----------Game " . ++$game. " w: $$w{name}   a: $$a{name}   r1: $$r1{name}   r2: $$r2{name}";
    my $sum = sub{ sum map $$_{ $_[0] } // 0, $w, $a, $r1, $r2 };
    my %player_input = ( hit=>100, map { ($_=>&$sum($_)) } 'damage', 'armor' );
    my @game_input = ( player => {%player_input}, boss => {%boss_input} );
    push( @lose_cost, &$sum('cost')), deb "lose_cost: ".$lose_cost[-1] if 'player' ne winner( @game_input );
}}}}

print "lose costs: @{[sort{$b<=>$a}@lose_cost]}\n";
print "Answer: ".max(@lose_cost)."\n";

sub winner {
    my($attacker,$defender) = @_[0,2];
    my %p = @_;
    while(1){
	my $reduce = $p{$attacker}{damage} - $p{$defender}{armor};
	$reduce = 1 if $reduce < 1;
	$p{$defender}{hit} -= $reduce;
	deb sprintf "The %-6s deals %2d - %2d = %2d damage; the %-6s goes down to %2d hit points.",
	    $attacker, $p{$attacker}{damage}, $p{$defender}{armor}, $reduce,$defender,$p{$defender}{hit};
	return $attacker if $p{$defender}{hit} <= 0 and deb "$attacker wins";
	($attacker,$defender) = ($defender,$attacker);
    }
}

#perl 2015_day_21_part_2.pl 2015_day_21_input.txt
#Answer: 201


__DATA__
Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0

Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5

Rings:      Cost  Damage  Armor
Damage +1    25     1       0
Damage +2    50     2       0
Damage +3   100     3       0
Defense +1   20     0       1
Defense +2   40     0       2
Defense +3   80     0       3

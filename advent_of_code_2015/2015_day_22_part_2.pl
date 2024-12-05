use v5.10;
use Time::HiRes qw(time);
use Storable qw(dclone);
use List::Util qw(min max uniq);

my $part = 2; #only this code differs in 2015_day_22_part_1.pl
              #                      and 2015_day_22_part_2.pl

my $runtime = @ARGV>1 ? pop(@ARGV) : 60; #sec

my %play =
    $ARGV[0] eq '2015_day_22_input.txt' ?
        ( Player => { hit=>50, mana=>500, armor=>0 },
          Boss => { map{/(\w+).*?(\d+)/;(lc$1=>$2)} <> } )
  : $ARGV[0] eq '1' ?
        ( Player => { hit=>10, mana=>250, armor=>0, spell=>['Poison','Magic Missile'] },
          Boss => { hit=>13, damage=>8} )
  : $ARGV[0] eq '2' ?
        ( Player => { hit=>10, mana=>250, armor=>0, spell=>['Recharge','Shield','Drain','Poison','Magic Missile'] },
          Boss => { hit=>14, damage=>8} )
  : die;

if($ARGV[0]=~/^[12]$/){
    play(%play)
}
else{
    my $n=0;
    my $min = 9e99;
    my @spent;
    my $start=time;
    while(++$n and time()-$start <= $runtime){
        my %p = %{ dclone\%play };
        my($winner,$spent) = play(%p);
        if( $winner eq 'Player' ){
            $min = $spent if $spent < $min;
            push @spent, $spent;
        }
        say "*** plays: $n   play winner: $winner   runtime so far: ".int(time-$start)."s   spent: $spent   min for Player, maybe Answer: $min";
    }
    say "*** plays: $n   Player-wins: ".@spent."   min spent and maybe Answer: ".min(@spent);
}

sub play {
    my %p = @_;
    my $winner;
    my $spent = 0;
    my %spell = (
        'Magic Missile' => {cost=>53, damage=>4,                                               msg=>", dealing 4 damage"},
        'Drain'    => {cost=>73, damage=>2, heals=>2,                                          msg=>", dealing 2 damage, and healing 2 hit points"},
        'Shield'   => {cost=>113, timer=>6, effect=>sub{"Shield's timer is now %s."         }, msg=>", increasing armor by 7"},
        'Poison'   => {cost=>173, timer=>6, effect=>sub{my$h=$p{Boss}{hit}-=3;"Poison deals 3 damage".
                                                          ($h>0?"; its timer is now %s.":do{$winner='Player';". This kills the boss, and the player wins."})} },
        'Recharge' => {cost=>229, timer=>5, effect=>sub{$p{Player}{mana}+=101; "Recharge provides 101 mana; its timer is now %s."} },
        );
    my @spelltypes = sort keys%spell;
    
    my $turn = 'Player';
    my $i=0;
    my @active;
    while(1){

        if( $part==2 and $turn eq 'Player' ){ $p{Player}{hit}--; $winner='Boss' and last if $p{Player}{hit} <= 0 }
        
        say "-- $turn turn --";
        say "- Player has $p{Player}{hit} hit points, $p{Player}{armor} armor, $p{Player}{mana} mana"=~s/ 1 hit point\Ks//r;
        say "- Boss has $p{Boss}{hit} hit points";
        
        @active=sort{$$b[2]cmp$$a[2]}@active;
        @active=grep{$$_[0]>0}map{
            my($time_left, $effect, $spell)=@$_;
            my $msg = sprintf(&$effect(),--$time_left);
            say $msg;
            say("Shield wears off, decreasing armor by 7."), $p{Player}{armor}-=7 if $spell eq 'Shield'   and !$time_left;
            say("Recharge wears off.")                                            if $spell eq 'Recharge' and !$time_left;
            [$time_left, $effect, $spell]
        }
        @active;
        
        last if $winner;
        
        if( $turn eq 'Player' ){
            my $spell=shift@{$p{Player}{spell}} || $spelltypes[rand@spelltypes];
            $p{Player}{armor}+=7 if $spell eq 'Shield';
            say "Player casts $spell".($spell{$spell}{msg}//'').".";
            $p{Player}{mana}-=$spell{$spell}{cost};
            $spent+=$spell{$spell}{cost};
            unshift @active, [@{$spell{$spell}}{'timer','effect'},$spell] if exists $spell{$spell}{effect};
            $winner='Boss' and last if @active > uniq(map$$_[2],@active); #no two of same with active effects
            $winner='Boss' and last if $p{Player}{mana} < 0;
            $p{Boss}{hit}-=$spell{$spell}{damage} if $spell{$spell}{damage};
            $p{Player}{hit}+=$spell{$spell}{heals} if $spell{$spell}{heals};
        }
        elsif( $turn eq 'Boss' ){
            my $mark = $ARGV[0] eq '1' ? '.' : '!';
            my $d = max(1,$p{Boss}{damage}-$p{Player}{armor});
            my $d_info = $p{Player}{armor} ? "$p{Boss}{damage} - $p{Player}{armor} = $d" : $d;
            say "Boss attacks for $d_info damage$mark";
            $p{Player}{hit} -= $d;
            $winner='Boss' and last if $p{Player}{hit} <= 0;
        }
        else{die}
        $turn = $turn eq 'Player' ? 'Boss' : 'Player';
        say;
    }
    return ($winner,$spent)
}
    
__END__

Answer: 1309

See the __END__ section in 2015_day_22_part_1.pl... but the diff commands there dont produce match for 2015_day_22_part_2.pl

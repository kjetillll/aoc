use v5.10; use strict; use warnings; use Algorithm::Combinatorics 'subsets'; use Storable 'dclone'; use List::Util 'min';
my @l = <>;
$l[1-1].="An elerium generator.
          An elerium-compatible microchip.
          A dilithium generator.
          A dilithium-compatible microchip.";

my @f = map [ map{/(.).(.)\S+ (.)\S+/g;uc(($2 eq 'o'?$2:$1).$3)} /(\S+ (?:microchip|generator))/g], @l;
my $items = 0 + map @$_, @f;
my $vrb = $ENV{VERBOSE};

sub info {
    my $e = shift;
    my @t = sort map @$_,@f;
    for my $f (4,3,2,1){
        say join ' ', "F$f", $e==$f?'E ':'. ', map in($_,@{$f[$f-1]})?$_:'. ', @t
    }
    print "pairs_pattern: ", pairs_pattern(@f), "\n\n";
}

sub pairs_pattern {
    my %l;
    for my $f (4,3,2,1){
        push(@{$l{substr($_,0,1)}},$f) for sort @{$f[$f-1]};
    }
    join' ', sort map { join '',sort(@$_) } values %l
}

info(1);

sub is_safeset{ my @g = grep/.G/,@_; not grep/.M/&&@g&&!in(s/M$/G/r,@g), @_ }
sub minus { my %seen; my %notme=map{($_=>1)}@{$_[1]}; grep !$notme{$_}&&!$seen{$_}++, @{$_[0]} }
sub in { my $val=shift; $_ eq $val and return 1 for @_; return 0 }

sub suggestions {
    my $e = shift;
    my $has_pair = 0;
    my @s1 = map [$_], @{ $f[$e-1] };
    my @s2 = @{ $f[$e-1] } < 2 ? ()
        : grep is_safeset(@$_),
          grep{ my $is_pair = "@$_"=~/^(.). \1/; !$is_pair or !$has_pair++ } #speedup: if > 1 pair, need just 1
          subsets($f[$e-1], 2);
    my $lowest = min grep 0+@{$f[$_-1]}, 1 .. 4;
    my @s_up = $items==4 ? (@s1,@s2) : @s2 ? @s2 : @s1; #hm items==4 example (bug)
    my @s_dn = $items==4 ? (@s1,@s2) : @s1 ? @s1 : @s2; #speedup, not 2 down if 1 exists, not 1 up if two exists
    map {
        my $to_e = $_;
        map [$e, $to_e, @$_],
        grep is_safeset( minus($f[$e-1], $_) ), #old floor safe
        grep is_safeset( @{$f[$to_e-1]}, @$_ ), #new floor safe
        $to_e > $e ? @s_up : @s_dn
    }
    grep $lowest <= $_ <= 4,
    $e-1, $e+1
}
my @w = map[1,@$_,dclone(\@f)],suggestions(1); #work work work
my($answer, $maxq, $i, $skip, %seen) = (-1,0,0,0);
while( @w ){
    $i++;
    $maxq = 0+@w if 0+@w > $maxq;

    my $work = shift @w;
    @f = @{ pop @$work };
    my($step, $from_e, $to_e, @t) = @$work;

    next if $seen{ $from_e, $to_e, "@t", pairs_pattern(@f) }++ and ++$skip; #huge speedup: seen eq pair pattern, not exact placement

    say "#$i   queue: ".@w."   maxq: $maxq   step: $step   from_e: $from_e   to_e: $to_e   things: @t" if $vrb;
    @{ $f[$from_e-1] } = grep !in($_, @t), @{ $f[$from_e-1] };
    push @{ $f[$to_e-1] }, @t;
    push @w, map [ $step + 1, @$_, dclone(\@f) ], suggestions($to_e);
    info($to_e) if $vrb and @w % 10 == 0;
    last if @{ $f[4-1] } == $items and $answer = $step; #all on upper floor
}
info(4);
say "i: $i   skip: $skip";
say "Answer: $answer";

# time perl 2016_day_11_part_2.pl 2016_day_11_input.txt  # 2.78 seconds
# Answer: 55

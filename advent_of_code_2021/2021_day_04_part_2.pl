use strict; use warnings; use v5.10;

my($drawn,@board) = split /\n\n/, join('',<>);
my(%numboard, %num_exists, %drawed, %count, %board_won);

for my $b ( 0 .. $#board ){
    my($x,$y) = (0,0);
    for my $num ( $board[$b] =~ /\d+/g ){
        $num_exists{$b}{$num} = 1;
        $numboard{$num}{$b} = { x=>$x++, y=>$y };
        $y++, $x=0 if $x==5;
    }
}

D:
for my $num ( $drawn =~ /\d+/g ){
    $drawed{$num} = 1;
    my $nbn = $numboard{$num};
    for my $b ( keys %$nbn ){
        my $horz = ++$count{$b}[     $$nbn{$b}{x} ];
        my $vert = ++$count{$b}[ 5 + $$nbn{$b}{y} ];
        if( $horz == 5 or $vert == 5 ){ #win
            $board_won{$b} = 1;
            if( +@board == keys %board_won ){
                say "last with bingo!   board: $b   horz: $horz   vert: $vert";
                say "Answer: ", $num * eval join '+', grep !$drawed{$_}, keys %{ $num_exists{$b} };
                last D
            }
        }
    }
}
# time perl 2021_day_04_part_2.pl 2021_day_04_input.txt    # 0.01 sec
# Answer: 34726

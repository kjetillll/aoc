use strict; use warnings; use v5.10;
my %points = ( ')' => 3,
               ']' => 57,
               '}' => 1197,
               '>' => 25137 );
my $answer = 0;
while(<>){
    my $err = 0;
    1 while not $err
            and s{ ( [\(\[\{\<] )
                   ( [\)\]\}\>] ) }{ $err = $2 if index( '()[]{}<>', $& ) < 0 }xe;
    $err and say "Expected ?, but found $err instead.";
    $err and $answer += $points{$err};
}
say "Answer: $answer";

# time perl 2021_day_10_part_1.pl 2021_day_10_input.txt     # 0.043 sec
# Answer: 387363

use v5.10;
my($x, $y) = (0, 2); #button 5
my @keypad = ( [qw( 0 0 1 0 0 )],
               [qw( 0 2 3 4 0 )],
               [qw( 5 6 7 8 9 )],
               [qw( 0 A B C 0 )],
               [qw( 0 0 D 0 0 )] );
say "Answer: ", map {
    for(/./g){
        my @backup = ($x, $y);
        /U/ ? $y-- :
        /D/ ? $y++ :
        /L/ ? $x-- :
        /R/ ? $x++ : die;
        ($x, $y) = @backup if $y<0 or $y>4 or $x<0 or $x>4 or !$keypad[$y][$x];
    }
    $keypad[$y][$x]
} <>;

# perl 2016_day_02_part_2.pl 2016_day_02_example.txt
# Answer: 5DB3

# perl 2016_day_02_part_2.pl 2016_day_02_input.txt
# Answer: 7423A

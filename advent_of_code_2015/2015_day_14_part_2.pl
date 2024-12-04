use v5.10; use List::Util qw(max);
while(<>){
    my $dist = 0;
    /(\w+) can fly (\d+) km.s for (\d+) seconds, but then must rest for (\d+) seconds\./||die;
    $reindeer{$1}{km} = [ map $dist+=$_, (( ($2) x $3, (0) x $4 ) x 2503)[0..2502] ];
}

my @r = values %reindeer;

for my $sec ( 0 .. 2502 ){
    my @s = sort {$$b{km}[$sec] <=> $$a{km}[$sec] } @r;
    $$_{points} += $$_{km}[$sec] == $s[0]{km}[$sec] ? 1 : last for @s;
}

say "Answer: ", max map $$_{points}, @r;

#Answer: 1059

use v5.10;
my $pos = 0;
my $id = 0;
for( <> =~ /\d/g ){
    $c++ % 2 == 0
        ? do{ push(@files, map [$pos++, $_, $id], 1 .. $_); $id++ }
        :     push(@free,  map  $pos++, 1 .. $_)
}

while( $files[-1][0] > $free[0] ){
    $files[-1][0] = shift @free;
    unshift @files, pop @files;
}

say "Answer: " . eval join '+', map $$_[0] * $$_[2], @files;

#Answer: 6211348208140

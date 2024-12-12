use v5.10; use List::Util 'sum';
my($x,$y,%grid,%group)=(0,0); while(<>){ $grid{$x++,$y} = $gl{$x,$y,$_} = $_ for /./g; $y++; $x=0 } #read input
my $gid=0;
for(sort keys %grid){
    my($x,$y,$l) = ( /\d+/g, $grid{$_} );
    next if $group{$x,$y};
    $group{$x,$y} = $l . ++$gid;
    my @go = ("$x$;$y");
    while(@go){
        my($gox,$goy) = split $;, shift @go;
        next if $group{$gox,$goy} and "$gox,$goy" ne "$x,$y";
        $group{$gox,$goy} = $group{$x,$y};
        push @go, grep $grid{$_} eq $l, map join($;,@$_),
            [$gox-1,$goy], [$gox+1,$goy], [$gox,$goy-1], [$gox,$goy+1];
    }
}
my(%a,%p);
for(keys%group){
    my($x,$y) = /\d+/g;
    my $g = $group{$_};
    $a{$g}++;
    $p{$g} += ( $g eq $group{$x-1,$y} ? 0 : 1 )
           +  ( $g eq $group{$x+1,$y} ? 0 : 1 )
           +  ( $g eq $group{$x,$y-1} ? 0 : 1 )
           +  ( $g eq $group{$x,$y+1} ? 0 : 1 );
}
say "Answer: " . sum map {say "$_: $a{$_} * $p{$_} = ", my $n = $a{$_} * $p{$_}; $n} sort keys %a;

# Answer: 1465968

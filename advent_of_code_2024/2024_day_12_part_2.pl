use v5.10; use List::Util 'sum';
my($x,$y,%grid,%region)=(0,0); while(<>){ $grid{$x++,$y} = $gl{$x,$y,$_} = $_ for /./g; $y++; $x=0 } #read input
my $rid=0;
for(sort keys %grid){                            #determine region id for each garden plot
    my($x,$y,$l) = ( /\d+/g, $grid{$_} );        #x y letter
    $has_side{$x,$y,'L'} = $l ne $grid{$x-1,$y}; #left
    $has_side{$x,$y,'R'} = $l ne $grid{$x+1,$y}; #right
    $has_side{$x,$y,'U'} = $l ne $grid{$x,$y-1}; #up
    $has_side{$x,$y,'D'} = $l ne $grid{$x,$y+1}; #down
    next if $region{$x,$y};
    $region{$x,$y} = $l . ++$rid;                #new region id
    my @go = ("$x$;$y");
    while( @go ){                                #spread region id to all connected same letter
        my($gox,$goy) = split $;, shift @go;
        next if $region{$gox,$goy} and "$gox,$goy" ne "$x,$y";
        $region{$gox,$goy} = $region{$x,$y};
        push @go, grep $grid{$_} eq $l, map join($;,@$_),
            [$gox-1,$goy], [$gox+1,$goy], [$gox,$goy-1], [$gox,$goy+1];
    }
}

#dont count sides more than one time, that is delete sides that has same side left or above
delete @has_side{ grep {
        my($x,$y,$dir) = /\w+/g;
        $grid{$x,$y} eq $grid{$x-1,$y} and $has_side{$x-1,$y,$dir} or
        $grid{$x,$y} eq $grid{$x,$y-1} and $has_side{$x,$y-1,$dir}
    } keys %has_side };

my(%area, %perimeter, %sides);  #add up
for(keys %grid){
    my($x, $y, $region) = ( /\d+/g, $region{$_} );
    $area{$region}++;
    $perimeter{$region} += ($region ne $region{$x-1,$y})
                        +  ($region ne $region{$x+1,$y})
                        +  ($region ne $region{$x,$y-1})
                        +  ($region ne $region{$x,$y+1});
    $sides{$region} += sum map $has_side{$x,$y,$_}, qw(L R U D);
}
say "Answer part 1: " . sum map $area{$_} * $perimeter{$_}, sort keys %area;
say "Answer part 2: " . sum map $area{$_} * $sides{$_},     sort keys %area;

# https://adventofcode.com/2024/day/12
# time perl 2024_day_12_part_2.pl 2024_day_12_input.txt  # 0.54 sec
# Answer part 1: 1465968
# Answer part 2: 897702

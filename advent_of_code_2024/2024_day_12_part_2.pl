use v5.10; use List::Util 'sum';
#sub dir{my@d=@_;sub{my($x,$y)=(pop()//$_)=~/\d+/g;join$;,$x+$d[0],$y+$d[1]}}
sub dir{my($X,$Y)=@_;sub{my($x,$y)=(pop()//$_)=~/\d+/g;join$;,$x+$X,$y+$Y}}
sub L{dir(-1,0)->(@_)}sub R{dir(1,0)->(@_)}sub U{dir(0,-1)->(@_)}sub D{dir(0,1)->(@_)}

my($x,$y,%grid,%region)=(0,0); while(<>){ $grid{$x++,$y} = $gl{$x,$y,$_} = $_ for /./g; $y++; $x=0 } #read input
my $rid=0;
for(sort keys %grid){                            #determine region id for each garden plot
    my($x,$y,$l) = ( /\d+/g, $grid{$_} );        #x y letter
    $has_perim{$x,$y,$$_[0]} = $l ne $grid{$$_[1]} for map[$_=>&$_("$x$;$y")], qw(L R U D);
    next if $region{$x,$y};
    my @go = ("$x$;$y");
    while( my $go = pop @go ){                                #spread region id to all connected same letter
        $region{$go} //= do{
	    push @go, grep $grid{$_} eq $l, map &$_($go), qw(L R U D);
	    $region{$_} // $l . ++$rid                        #old or if not exists new region id
	}
    }
}

my %has_side = %has_perim;
delete @has_side{ grep { #stops double-count for perim
        my($x,$y,$dir) = /\w+/g;
        $grid{$x,$y} eq $grid{$x-1,$y} and $has_perim{$x-1,$y,$dir} or
	$grid{$x,$y} eq $grid{$x,$y-1} and $has_perim{$x,$y-1,$dir}
    } keys %has_side };

my(%area, %perimeter, %sides);  #add up
for(keys %grid){
    my($x, $y, $region) = ( /\d+/g, $region{$_} );
    $area{$region}++;
    $perimeter{$region} += sum map $has_perim{$x,$y,$_}, qw(L R U D);
    $sides{$region}     += sum map $has_side{$x,$y,$_},  qw(L R U D);
}
say "Answer part 1: " . sum map $area{$_} * $perimeter{$_}, sort keys %area;
say "Answer part 2: " . sum map $area{$_} * $sides{$_},     sort keys %area;

# https://adventofcode.com/2024/day/12
# time perl 2024_day_12_part_2.pl 2024_day_12_input.txt  # 0.54 sec
# Answer part 1: 1465968
# Answer part 2: 897702

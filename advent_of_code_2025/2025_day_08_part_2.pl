use strict; use warnings; use v5.10; use List::Util qw(uniq);
my $N = $ARGV[0] =~ /example/ ? 10 : 1000;
my $i = 0;
my @box = map { /(\d+),(\d+),(\d+)/; { i=>$i++, x=>$1, y=>$2, z=>$3 } } <>;
say "boxes: ".@box."   N: $N";
my %dist;
for my $a (@box){
for my $b (@box){
    next if $$a{i} >= $$b{i};
    $dist{ $$a{i}, $$b{i} } = ( $$a{x} - $$b{x} ) ** 2
                            + ( $$a{y} - $$b{y} ) ** 2
                            + ( $$a{z} - $$b{z} ) ** 2;
}}
say "pairs: ".keys%dist;
my @pairs = ( sort { $dist{$a} <=> $dist{$b} || $a cmp $b }keys%dist);#[ 0 .. $N-1];
say "pairs: ".@pairs;
my($pn, $groups, @group) = (0,0);
for(@pairs){     # N closest pairs
    my($i_a, $i_b) = /(\d+)$;(\d+)/;  #index of a and b in pair
    if(defined $group[$i_a] and defined $group[$i_b] and $group[$i_a] != $group[$i_b] ){
        my($min, $max) = $group[$i_a] < $group[$i_b] ? @group[$i_a, $i_b]
                                                     : @group[$i_b, $i_a];
        $group[$_] = $min for grep $max == ($group[$_]//-1), 0..$#group;  #join groups
    }
    else {  #init group for one or both
        $group[$i_a] //= $group[$i_b] // ++$groups;
        $group[$i_b] //= $group[$i_a];
    }
    $ENV{VERBOSE} and say "pn: ".++$pn."   i_a: $i_a   i_b: $i_b   unconnected: ".grep!defined,@group;
    say "Answer: ", $box[$i_a]{x} * $box[$i_b]{x} and last if !grep !defined, @group;
}
__END__
my %freq; defined and $freq{ $_ }++ for @group;
my $largest_3 = join ' * ', ( sort {$b<=>$a} values %freq )[0, 1, 2];
say "Answer: ",      $largest_3;
say "Answer: ", eval $largest_3;


# perl 2025_day_08_part_2.pl 2025_day_08_example.txt
# Answer: 25272

# perl 2025_day_08_part_2.pl 2025_day_08_input.txt     # 2.61 seconds
# Answer: 44543856

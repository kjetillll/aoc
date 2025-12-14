use v5.10; use strict; use warnings;

sub transpose { my($s, @t) = @_; for( split /\n/, $s ){ my $i = 0; $t[ $i++ ] .= $_ for split // } join "", map "$_\n", @t }
sub rotate {my($s, $id, $len, $count)=@_; substr($s,$id*($len+1),$len) = substr($s,($id+1)*($len+1)-2,1) . substr($s,$id*($len+1),$len-1) for 1..$count; $s}

my($width, $height) = (50,6);
my $screen = join "\n", ("." x $width) x $height;
$screen =
  /rect (\d+)x(\d+)/               ? do{ substr($screen,$_*($width+1),$1) = '#' x $1 for 0 .. $2-1; $screen } :
  /rotate row y=(\d+) by (\d+)/    ? rotate($screen,$1,$width,$2) :
  /rotate column x=(\d+) by (\d+)/ ? transpose(rotate(transpose($screen),$1,$height,$2)) : die
while <>;
say "Answer:\n\n$screen";

__END__

perl 2016_day_08_part_2.pl 2016_day_08_input.txt   # UPOJFLBCEZ
Answer:

#..#.###...##....##.####.#....###...##..####.####.
#..#.#..#.#..#....#.#....#....#..#.#..#.#.......#.
#..#.#..#.#..#....#.###..#....###..#....###....#..
#..#.###..#..#....#.#....#....#..#.#....#.....#...
#..#.#....#..#.#..#.#....#....#..#.#..#.#....#....
.##..#.....##...##..#....####.###...##..####.####.

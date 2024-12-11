use v5.10; use List::Util 'sum';
my($steps, @input, %memoization) = (75, <>=~/\d+/g);
say "Answer: ".sum map stones($_,1), @input;
say "memoization keys: ".keys%memoization;

sub stones {
    my($stone, $step) = @_;
    my $len = length($stone);
    $memoization{$stone,$step} //=   #much needed memoization for steps > ~30
    $step == $steps + 1 ? 1
  : $stone == 0         ? stones(1,                       $step + 1)
  : $len % 2 == 0       ? stones(substr($stone,0,$len/2), $step + 1)
                         +stones(0+substr($stone,$len/2), $step + 1)
  :                       stones($stone * 2024,           $step + 1)
}

# https://adventofcode.com/2024/day/11
# time perl 2024_day_11_part_2.pl 2024_day_11_input.txt    # 0.15 sec
# Answer: 236804088748754
# memoization keys: 132570

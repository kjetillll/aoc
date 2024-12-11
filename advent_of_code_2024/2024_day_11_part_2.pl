use v5.10; use List::Util 'sum';
my @inp = <> =~ /\d+/g;
my $steps = 75;
say "Answer: ".sum map stones($_,1), @inp;
say "memoization keys: ".keys%memoization;

sub stones {
    my($s,$step)=@_;
    my $len = length($s);
    $memoization{$s,$step} //=   #much needed memoization for steps > ~30
    $step == $steps ? $s == 0 ? 1 : $len % 2 == 0 ? 2 : 1
  : $s == 0         ? stones(1,                   $step+1)
  : $len % 2 == 0   ? stones(substr($s,0,$len/2), $step+1)
                     +stones(0+substr($s,$len/2), $step+1)
  :                   stones($s*2024,             $step+1)
}

# https://adventofcode.com/2024/day/11
# time perl 2024_day_11_part_2.pl 2024_day_11_input.txt    # 0.14 sec
# Answer: 236804088748754
# memoization keys: 128799

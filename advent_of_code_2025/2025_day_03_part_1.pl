use strict; use warnings; use v5.10; use List::Util qw(max reduce);
my $sum = 0;
my @s = map s/\D//gr,<>;

# for my $s (@s){
#     for(grep!/0/,reverse("11".."99")){
#         my($t,$o)=/\d/g;
#         my $re="$t.*$o";
#         if($s=~/$re/){
#             $sum+=$_;
#             say"tens: $t   ones: $o";
#             last;
#         }
#     }
# }

for(map [/\d/g], @s){
    my $i = max_idx( @$_[ 0 .. $#$_ - 1] );
    my $tens = $$_[$i];
    splice @$_, 0, $i + 1;
    my $ones = max( @$_ );
    say "tens: $tens   ones: $ones" if $ENV{VERBOSE};
    $sum += $tens * 10 + $ones;
}
say "Answer: $sum";

sub max_idx { reduce { $_[$a] > $_[$b] ? $a : $b } reverse 0..$#_ }
#sub max_idx { my($i,$max)=(-1);for(0..$#_){if(!defined$max or $_[$_]>$max){$max=$_[$_];$i=$_}}$i}

# perl 2025_day_03_part_1.pl 2025_day_03_example.txt
# Answer: 357

# perl 2025_day_03_part_1.pl 2025_day_03_input.txt     # 0.017 seconds
# Answer: 17278

use v5.10;
my @a=<>=~/\d+/g;
say "@a";
for(1..25){
    @a = map{
        $_==0         ? (1)
      : length()%2==0 ? (substr($_,0,length()/2), 0+substr($_,length()/2))
      :                 ($_*2024)
    } @a;
    say "$_: ".@a.(@a<10 ? "   (@a)" : "   (@a[0..9]...)");
}
say "Answer: " . @a;

# https://adventofcode.com/2024/day/11
# time perl 2024_day_11_part_1.pl 2024_day_11_input.txt    # 0.15 sec
# Answer: 199986

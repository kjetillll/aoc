use v5.10; use strict; use warnings; use Algorithm::Combinatorics 'permutations';

eval q{
  my($n, $i, @c);
  for( my @p = permutations(['a'..'h']) ){
      printf "checked %d of %d permutations\r", ++$n, 0+@p;
      @c = @$_;
      ¤;
      say("\nAnswer: ", join'', @$_) and last if join('',@c) eq 'fbgdceah';
  }
} =~ s{¤}{
  join ';', map
    /swap position (\d+) with position (\d+)/ ? qq( \@c[$1,$2] = \@c[$2,$1] )
   :/swap letter (.) with letter (.)/         ? qq( y/$1$2/$2$1/ for \@c )
   :/rotate left (\d+) step/                  ? qq( push \@c, shift \@c for 1 .. $1 )
   :/rotate right (\d+) step/                 ? qq( unshift \@c, pop \@c for 1 .. $1 )
   :/rotate based on position of letter (.)/  ? qq( \$i = index join('',\@c),"$1"; unshift \@c, pop \@c for 1 .. 1+\$i+(\$i>=4) )
   :/reverse positions (\d+) through (\d+)/   ? qq( \@c[$1..$2] = reverse \@c[$1..$2] )
   :/move position (\d+) to position (\d+)/   ? qq( splice \@c, $2, 0, splice \@c, $1, 1 )
   :die,
   <>
}er

# perl 2016_day_21_part_2.pl 2016_day_21_input.txt      # 0.26 seconds
# checked 4306 of 40320 permutations
# Answer: aghfcdeb

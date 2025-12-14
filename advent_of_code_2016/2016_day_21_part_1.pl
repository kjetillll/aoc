use v5.10; use strict; use warnings;

my $start = $ARGV[0] =~ /example/ ? 'abcde'
          : $ARGV[0] =~ /input/   ? 'abcdefgh'
          : die;

my @c = $start =~ /./g;
while( <> ){
    say join('',@c) if $ENV{VERBOSE};
    printf "%-50s  %s   ", s/\n//r, join('',@c) if $ENV{VERBOSE};
    if   ( /swap position (\d+) with position (\d+)/ ) { @c[$1,$2] = @c[$2,$1] }
    elsif( /swap letter (.) with letter (.)/         ) { eval "y/$1$2/$2$1/ for \@c" }
    elsif( /rotate left (\d+) step/                  ) { push @c, shift @c for 1 .. $1 }
    elsif( /rotate right (\d+) step/                 ) { unshift @c, pop @c for 1 .. $1 }
    elsif( /rotate based on position of letter (.)/  ) { my $i = index(join('',@c),$1); unshift @c, pop @c for 1 .. 1 + $i + ($i>=4) }
    elsif( /reverse positions (\d+) through (\d+)/   ) { @c[$1..$2] = reverse @c[$1..$2] }
    elsif( /move position (\d+) to position (\d+)/   ) { splice @c, $2, 0, splice @c, $1, 1 }
    else{die}
}
say "Answer: ", join('',@c);

# perl 2016_day_21_part_1.pl 2016_day_21_input.txt      # 0.008 seconds
# Answer: dbfgaehc

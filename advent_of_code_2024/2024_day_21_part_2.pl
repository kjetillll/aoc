use strict; use warnings; use v5.10; use List::Util qw(min sum); use Memoize;

my @inp = map s,\n,,r, <>;

my %num = (  7 => [0,0],  8 => [1,0],  9 => [2,0],
             4 => [0,1],  5 => [1,1],  6 => [2,1],
             1 => [0,2],  2 => [1,2],  3 => [2,2],
                          0 => [1,3],  A => [2,3],
             avoid => qr/^( 1v | 4vv | 7vvv | 0< | A<< )/x ); # avoid: $start . str
my %dir = (              '^'=> [1,0],  A => [2,0],
            '<'=> [0,1], 'v'=> [1,1], '>'=> [2,1],
             avoid => qr/^( \^< | <\^ | A<< )/x );

sub possibles {
    my($start, $end, $kbd) = @_;
    my($sx, $sy) = @{ $$kbd{$start} }[0,1];
    my($ex, $ey) = @{ $$kbd{$end  } }[0,1];
    my $xarr = ($sx < $ex ? '>' : '<') x abs $ex-$sx;
    my $yarr = ($sy < $ey ? 'v' : '^') x abs $ey-$sy;
    grep "$start$_" !~ $$kbd{avoid},
    $xarr && $yarr ? ( $xarr.$yarr, $yarr.$xarr )
                   : ( $xarr.$yarr              )
}    

sub minseqlen {
    my($str, $level, $not_first) = @_;
    memoize('minseqlen') if not $not_first;
    return length $str if $level == 0;
    my $len = 0;
    my $kbd = $not_first ? \%dir : \%num;
    my @str = ('A', split(//,$str), $not_first ? 'A' : ());
    sum map $_ + ($level==1),
        map {
            my($start, $end) = @str[ $_, $_+1 ];
            min map minseqlen($_, $level-1, 1), possibles($start, $end, $kbd);
        }
        0 .. $#str-1;
}

sub complexity {
    my($code, $levels) = @_;
    my $numpart = $code =~ s/\D//gr =~ s/^0+//gr;
    my $len = minseqlen($code, $levels);
    $numpart * $len
}

say "Answer part 1: " . sum map complexity($_, 1 + 2),  @inp;
say "Answer part 2: " . sum map complexity($_, 1 + 25), @inp;

# time perl 2024_day_21_part_2.pl 2024_day_21_input.txt    # 0.013 sec
# Answer part 1: 278568
# Answer part 2: 341460772681012

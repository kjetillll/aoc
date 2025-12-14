use v5.10; use strict; use warnings; use Digest::MD5 'md5_hex';

sub f {
    my $input = shift;
    my @w = ( {x => 0, y => 0, so_far => ''} );
    my %dir = ( U => {x =>  0, y => -1},
                D => {x =>  0, y => 1},
                L => {x => -1, y => 0},
                R => {x =>  1, y => 0} );
    my $longest = -1;
    while( @w ){
        my($x, $y, $so_far) = @{ shift @w }{ qw(x y so_far) };
        
        next if $x == 3 and $y == 3 and $longest = length($so_far);

        my @is_open = map -/[b-f]/, substr( md5_hex($input . $so_far), 0, 4 ) =~ /./g;

        push @w,
            grep 0 <= $$_{x} <= 3,
            grep 0 <= $$_{y} <= 3,
            map {
                { x      => $x + $dir{$_}{x},
                  y      => $y + $dir{$_}{y},
                  so_far => $so_far . $_ }
            }
            grep shift(@is_open),
            qw(U D L R);
    }
    $longest
}

while(<>){
    my $input = s/\W//gr;
    say "Answer: ", f($input);
}

# perl 2016_day_17_part_2.pl 2016_day_17_example.txt
# Answer: -1
# Answer: 370
# Answer: 492
# Answer: 830
   
# perl 2016_day_17_part_2.pl 2016_day_17_input.txt      # 0.14 seconds
# Answer: 420

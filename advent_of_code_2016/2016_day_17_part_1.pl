use v5.10; use strict; use warnings; use Digest::MD5 'md5_hex';

use Test::More tests => 4;
is f('hijkl'),    '';
is f('ihgpwlah'), 'DDRRRD';
is f('kglvqrro'), 'DDUDRLRRUDRD';
is f('ulqzkmiv'), 'DRURDRUDDLLDLUURRDULRLDUUDDDRR';

sub f {
    my $input = shift;
    my @w = ( {x => 0, y => 0, so_far => ''} );
    my %dir = ( U => {x =>  0, y => -1},
                D => {x =>  0, y => 1},
                L => {x => -1, y => 0},
                R => {x =>  1, y => 0} );
    while( @w ){
        my($x, $y, $so_far) = @{shift@w}{qw(x y so_far)};
        
        return $so_far if $x == 3 and $y == 3;
        my @is_open = map -/[b-f]/, substr(md5_hex($input . $so_far),0,4) =~ /./g;
        my @dir = grep shift(@is_open), qw(U D L R);
        push @w,
            grep 0 <= $$_{x} <= 3,
            grep 0 <= $$_{y} <= 3,
            map {
                { x => $x + $dir{$_}{x},
                  y => $y + $dir{$_}{y},
                  so_far => $so_far . $_ }
            }
            @dir;
    }
    '';
}

while(<>){
    my $input = s/\W//gr;
    say "Answer: ".( f($input) || ' (empty)' );
}

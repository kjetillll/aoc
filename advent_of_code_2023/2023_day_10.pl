# https://adventofcode.com/2023/day/10 - del 1
# kjør:
#
# perl 2023_day_10_part_2.pl 2023_day_10_ex.txt      # svar: 4
# perl 2023_day_10_part_2.pl 2023_day_10_ex2.txt     # svar: 8
# perl 2023_day_10_part_2.pl 2023_day_10_ex3.txt     # svar: 23
# perl 2023_day_10_part_2.pl 2023_day_10_ex4.txt     # svar: 70
# perl 2023_day_10_part_2.pl 2023_day_10_ex7.txt     # svar: 22
# perl 2023_day_10_part_2.pl 2023_day_10_ex9.txt     # svar: 80
#
# perl 2023_day_10_part_2.pl 2023_day_10_input.txt  # svar: 6968          0.12 sek

my $kart = join '', <>;
sub tegn{ substr $kart, pop, 1 }
my $w = 1 + length($kart =~ /.*/ ? $& : die);
my $start = $kart =~ /^.*S/s ? -1 + length $& : die;
print "<<\n$kart>>\n";
print "start pos: $start   width: $w\n";

my %hopp = ('F' => [$w,1],
	    '7' => [$w,-1],
	    '|' => [$w,-$w],
	    '-' => [-1,1],
	    'L' => [-$w,1],
	    'J' => [-$w,-1] );

printf "svar: %d\n", distanse($start) / 2;

sub in { my $val = shift; $_ eq $val and return 1 for @_; 0 }

sub distanse {
    my($h, $f, $d) = @_;
    my $n = tegn($h);
    my @g = grep { $h + $_ != $f } @{ $hopp{$n} };
    if( @_<2 ){
	push @g,-$w if in( tegn($h-$w), '|', '7', 'F' );
	push @g, $w if in( tegn($h+$w), '|', 'J', 'L' );
	push @g, -1 if in( tegn($h-1),  '-', 'L', 'F' );
	push @g,  1 if in( tegn($h+1),  '-', 'J', '7' );
    }
    print "h: $h   f: $f   d: $d   n: $n   g: @g\n";
    die if !@g and $n ne 'S';
    my $g = $g[0];
    @_>1 && $n eq 'S' ? $d : distanse($h+$g,$h,1+$d)
}

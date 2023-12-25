# https://adventofcode.com/2023/day/10 - del 2
# kjør:
#
# perl 2023_day_10_part_2.pl 2023_day_10_input.txt  # svar: 413          1.62 sek
#
# TODO: hm, for uflaks-input burde S erstattes av en av | - 7 F J L

use experimental 'smartmatch';

my $kart = join'',<>;
sub kart { substr $kart, shift, 1 }
sub kart_er { kart(shift) ~~ @_ }
my $w = $kart=~/.*/?1+length$&:die;
my $s = $kart=~/^.*S/s?-1+length$&:die; kart_er($s,'S') or die;
print "start pos: $s   width: $w\n";

my %hopp = ( 'F' => [ $w, 1],
	     '7' => [ $w, -1],
	     '|' => [ $w, -$w],
	     '-' => [ -1, 1],
	     'L' => [ -$w, 1],
	     'J' => [ -$w, -1] );
my @loop = loop($s);
printf "loop-lengde: %d\n", 0 + @loop;
printf "max avstand: %d\n", @loop / 2;
my %is_loop = map { ($_=>1) } @loop;
my($inne, $grensepasseringer, $pos) = (0,0,0);

while( $pos < length $kart ){
    if( $kart =~ /^ .{$pos}( \| | L-*7 | F-*J )/sx  #fordi L7 og FJ teller som | i grensepasseringer
	and $is_loop{$pos} )
    {
        $pos += length $1;
        $grensepasseringer++;
    }
    elsif( !$is_loop{ $pos++ } ){
        $inne += $grensepasseringer % 2 ;           #odde antall loddrette grensepasseringer => inne!
    }
}
print "svar: $inne (antall inne)\n";

sub loop {
    my($h, $f, $l) = @_;                            #her, fra, loopliste så langt
    my $foerste = ( grep { $h + $_ != $f } @{ $hopp{ kart($h) } } )[0];
    my $hopp =
      $l                                 ? $foerste #en av de to retningene, ikke dit man kom fra
      : kart_er( $h - $w, '|', '7', 'F') ? -$w
      : kart_er( $h + $w, '|', 'J', 'L') ?  $w
      : kart_er( $h - 1 , '-', 'L', 'F') ? -1
      : kart_er( $h + 1 , '-', 'J', '7') ?  1 : die;
    $l && $h == $s ? @$l : do{ $l //= []; push @$l, $h; loop( $h + $hopp, $h, $l ) }
}

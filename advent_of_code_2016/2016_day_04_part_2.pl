use v5.10; use strict; use warnings;

say "Answer: $_" for map {
    my($name, $id, $checksum) = /^ (.+) - (\d+) \[ ([a-z]+) \] /x;
    my $name_decrypted = $name =~ s{ \w }{ rotate($&, $id) }xger;
    $ENV{VERBOSE} and say "   n: $name   d: $name_decrypted   i: $id   c: $checksum";
    $name_decrypted =~ /north/ ? $id : ()
} <>;

sub rotate { chr( 97 + ( ord(shift()) - 97 + shift() ) % 26 ) }

# perl 2016_day_04_part_2.pl 2016_day_04_input.txt
# Answer: 501
    

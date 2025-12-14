use v5.10; use strict; use warnings;

die if checksum('110010110100')         ne '100';
die if checksum('10000011110010000111') ne '01100';
die if dragon('10000') ne '10000011110';
die if dragon(dragon('10000')) ne '10000011110010000111110';

my $input = <> =~ s/\D//gr;
my $fill = $input eq '10000' ? 20 #the example
         : $0 =~ /part_1/    ? 272
         : $0 =~ /part_2/    ? 35651584 : die;

say "input: $input   len: ".length($input)."   fill: $fill";

$input = dragon($input) while length($input) < $fill;
$input = substr($input, 0, $fill);

say "Answer: ", checksum($input);

sub checksum { length($_[0]) % 2 ? $_[0] : checksum( $_[0] =~ s/(.)(.)/$1-$2?0:1/ger ) }
sub dragon { $_[0] . 0 . ( "".reverse($_[0]) =~ y/01/10/r ) }

# perl 2016_day_16_part_1.pl 2016_day_16_example.txt
# Answer: 01100

# perl 2016_day_16_part_1.pl 2016_day_16_input.txt     # 0.008 seconds
# Answer: 10111110010110110

# perl 2016_day_16_part_2.pl 2016_day_16_input.txt     # 9.91 seconds
# Answer: 01101100001100100

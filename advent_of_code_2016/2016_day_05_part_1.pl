use v5.10; use strict; use warnings; use Digest::MD5 'md5_hex';

my $inp = <> =~ s/\W//gr;
my $i = 0;

say "Answer: ", join '', map {
    1 while md5_hex( $inp . $i++ ) !~ /^0{5}(.)/;
    $ENV{VERBOSE} and say "char no $_ is $1";
    $1
}
1..8;


# time VERBOSE=1 perl 2016_day_05_part_1.pl 2016_day_05_example.txt  # 3.0 seconds
# Answer: 18f47a30

# time VERBOSE=1 perl 2016_day_05_part_1.pl 2016_day_05_input.txt    # 3.5 seconds
# Answer: d4cd2ee1

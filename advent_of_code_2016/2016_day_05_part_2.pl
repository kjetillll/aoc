use v5.10; use strict; use warnings; use Digest::MD5 'md5_hex';

my $inp = <> =~ s/\W//gr;
my $i = 0;
my $password = '_' x 8;
while( $password =~ /_/ ){
    1 while md5_hex( $inp . $i++ ) !~ / ^ 0{5} ( [0-7] ) ( . ) /x;
    my($pos, $char) = ($1, $2);
    $password =~ s/^.{$pos}\K_/$char/;
    say "i: $i   password: $password" if $ENV{VERBOSE};
}

say "Answer: $password";

# time VERBOSE=1 perl 2016_day_05_part_2.pl 2016_day_05_example.txt  # 3.55 seconds
# Answer: 05ace8e3

# time VERBOSE=1 perl 2016_day_05_part_2.pl 2016_day_05_input.txt    # 8.77 seconds
# Answer: f2c730e5

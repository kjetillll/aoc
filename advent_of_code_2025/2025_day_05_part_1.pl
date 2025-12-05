use strict; use warnings; use v5.22;
my $inp = join '', <>;
my @r = map [/\d+/g], split /\n/, ( split /\n\n/, $inp )[0];
my @id =              split /\n/, ( split /\n\n/, $inp )[1];
say "Answer: ", 0 + grep { my $id = $_; grep { $$_[0] <= $id <= $$_[1] } @r } @id;


# perl 2025_day_05_part_1.pl 2025_day_05_example.txt
# Answer: 3

# perl 2025_day_05_part_1.pl 2025_day_05_input.txt     # 0.05 seconds
# Answer: 701

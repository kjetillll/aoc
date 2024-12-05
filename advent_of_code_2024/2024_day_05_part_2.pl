use v5.10; use List::Util 'any';

my @lines = map [/\d+/g], <>; #input lines

my @r = grep @$_==2, @lines;  #rules have two numbers
my @u = grep @$_!=2, @lines;  #updates dont have two

my %r; for(@r){ my($a,$b)=@$_; $r{$a,$b}=1; $r{$b,$a}=-1 } # %r = sort() rules

say "Answer: ",
    eval
    join '+',
    map $$_[ $#$_ / 2 ],
    grep {
        my $u = $_;
        my %u; @u{@$u} = ();
        any { my($a,$b)=@$_; exists $u{$a} and exists $u{$b} and "@$u" !~ /\b$a\b.*\b$b\b/x } @r #if any rule broken
        and $_ = [ sort { $r{$a,$b} } @$_ ] #if so fix order
    }
    @u

#time perl 2024_day_05_part_2.pl 2024_day_05_input.txt  #0.07 sec
#Answer: 4713

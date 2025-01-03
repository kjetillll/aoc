use v5.10;

while(<>){
    my($from,$to)=/\w+/g;
    push @{ $fromto{$from} }, $to;
    push @{ $fromto{$to}   }, $from;
}

my @work = ( ['start'] );
my %seen;
while( @work ){
    my @path = @{ shift @work };
    next if $seen{ join '-', @path }++;
    next if $path[-1] eq 'end';
    my %small; @small{ grep /^[a-z]+$/, @path } = ();
    push @work, map[ @path, $_ ], grep ! /start/, grep ! exists $small{$_}, @{ $fromto{ $path[-1] } };
}

say "Answer: " . grep /-end$/, keys %seen;

# time perl 2021_day_12_part_1.pl 2021_day_12_input.txt     # 0.072 sec
# Answer: 5333


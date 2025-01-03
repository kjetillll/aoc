use v5.10;

while(<>){
    my($from,$to)=/\w+/g;
    push @{ $fromto{$from} }, $to;
    push @{ $fromto{$to}   }, $from;
}

sub bad_path_part_1 {
    my %visits; $visits{$_}++ for grep !/[A-Z]/, @_;
    0+grep $_>1, values %visits;
}

sub bad_path_part_2 {
    my $limit = 2;
    my %seen;
    for(@_){
        next if /[A-Z]/;
        return 1 if ++$seen{$_} > $limit;
        $limit = 1 if $seen{$_} == 2;
    }
    return 0;
}
    
my @work = ( ['start'] );
my %seen;
while( @work ){
    my @path = @{ shift @work };
    next if $seen{ join '-', @path }++;
    next if $path[-1] eq 'end';
    push @work, map [ @path, $_ ], grep /[A-Z]/ || !bad_path_part_2(@path,$_), grep !/^start$/, @{ $fromto{ $path[-1] } };
}
say "Answer: " . grep /-end$/, keys %seen;

# time perl 2021_day_12_part_2.pl 2021_day_12_input.txt     # 4.90 sec
# Answer: 146553


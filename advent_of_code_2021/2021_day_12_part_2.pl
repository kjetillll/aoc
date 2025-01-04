while(<>){
    my($from,$to)=/\w+/g;
    push @{ $fromto{$from} }, $to   if $from ne 'end' and $to ne 'start';
    push @{ $fromto{$to}   }, $from if $from ne 'start' and $to ne 'end';
}

sub bad_path {
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
    push @work, map [ @path, $_ ],
                grep /[A-Z]/ || !bad_path(@path,$_),
                @{ $fromto{ $path[-1] } };
}
printf "Answer: %d\n", 0 + grep /-end$/, keys %seen;

# time perl 2021_day_12_part_2.pl 2021_day_12_input.txt     # 4.90 sec
# Answer: 146553


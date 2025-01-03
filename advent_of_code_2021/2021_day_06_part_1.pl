use v5.10;
my @fish = <> =~ /\d+/g;
my $days = 80;
sub info { say "day $_   count: ".@fish."   fish: ".join(",",@fish[0..30]) }
for( 1 .. $days ){
    info();
    my @new;
    for(@fish){
        $_--;
        if($_==-1){
            push @new, 8;
            $_ = 6;
        }
    }
    push @fish, @new;
}
info();
say "Answer: " . @fish;

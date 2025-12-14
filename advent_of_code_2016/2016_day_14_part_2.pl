use v5.10; use strict; use warnings; use Digest::MD5 'md5_hex';
my $salt = <> =~ s/\W//gr;
my(@key, @m);
my $i = 0;
my @hexvals = ( 0 .. 9, 'a' .. 'f' );
my %fivepos = map { $_ => [] } @hexvals;
while(1){
    my $hash = hash($i);
    my $c = { i => $i, md5 => $hash};        #candidate
    $$c{triplet} = $1 if $hash =~ /(.)\1\1/; #...has triplet
    for( $hash =~ /(.)\1\1\1\1/g ){          #...has fives
        my $char = substr($_,0,1);
        push @{ $fivepos{$char} }, { i => $i };
    }
    push @m, $c;           #mem candidates
    if(@m == 1001){        #but only 1001 of then
        my $cb = shift @m; #candicate 1000 before
        for my $char ( @hexvals ){
            shift @{ $fivepos{$char} } while @{ $fivepos{$char} } and $fivepos{$char}[0]{i} <= $$cb{i} #prune
        }
        if( exists $$cb{triplet} and @{$fivepos{$$cb{triplet}}} ){
            push @key, $cb;
            say "Answer: $$cb{i}" and exit if @key == 64;
        }
    }
    $i++;
}

sub hash {
    my $hash = $salt . shift();
    my $stretching = $0 =~ /part_1/ ? 0 : 2016;
    $hash = md5_hex($hash) for 0 .. $stretching;
    $hash
}

# perl 2016_day_14_part_2.pl 2016_day_14_example.txt   # 11.4 seconds
# Answer: 22551

# perl 2016_day_14_part_2.pl 2016_day_14_input.txt     # 11.3 seconds
# Answer: 22429

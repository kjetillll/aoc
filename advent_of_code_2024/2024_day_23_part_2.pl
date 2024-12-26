use strict; use warnings; use v5.10;

my %graph;

while(<>){
    /(\w+)-(\w+)/;
    $graph{ $1 }{ $2 } = 1;
    $graph{ $2 }{ $1 } = 1;
}

sub bron_kerbosch {  #BK algorithm finds max cliques
    my($graph, $r, $p, $x) = @_;
    return [ @$r ] if !@$p and !@$x;  # found a maximal clique, add it to the result
    my @cliques;
    for my $v (@$p) { # for all vertices in P
        my @new_r = (@$r, $v);
        my @new_p = grep $graph->{$v}{$_}, @$p;
        my @new_x = grep $graph->{$v}{$_}, @$x;
        push @cliques, bron_kerbosch($graph, \@new_r, \@new_p, \@new_x); # expand the clique
        @$p = grep { $_ ne $v } @$p; # Move v from P to X
        push @$x, $v;
    }
    @cliques;
}

sub largest_clique {
    # a clique is a subgraph where all nodes are connected to all others in that subgraph
    my $graph = shift;
    # init sets
    my @r;
    my @p = keys %$graph; #vertices
    my @x;

    # find all maximal cliques using Bron-Kerbosch
    my @cliques = bron_kerbosch($graph, \@r, \@p, \@x);

    # find largest clique
    my @largest_clique;
    @$_ > @largest_clique and @largest_clique = @$_ for @cliques;
    @largest_clique;
}
my $ans = join ',', sort( largest_clique(\%graph) );
say "Answer: $ans";

# Answer: ar,cd,hl,iw,jm,ku,qo,rz,vo,xe,xm,xv,ys
# time perl 2024_day_23_part_2.pl 2024_day_23_input.txt # 0.29 sec

use v5.10; use List::Util 'sum';
my $root = {name=>'/', parent=>undef};
my $pwd = $root;
while(<>){
    if   ( m,^\$ cd /,     ){ $pwd = $root }
    elsif( m,^\$ cd \.\.,  ){ $pwd = $$pwd{parent} }
    elsif( m,^\$ cd (\S+), ){ $$pwd{files}{$1} //= {name=>$1, parent=>$pwd}; $pwd = $$pwd{files}{$1} }
    elsif( m,^\$ ls,       ){}
    elsif( m,^dir (\S+),   ){ $$pwd{files}{$2} //= {name=>$2, parent=>$pwd} }
    elsif( m,^(\d+) (\S+), ){ $$pwd{files}{$2} //= {name=>$2, parent=>$pwd, size=>$1} }
}
my @sz;
sub sz { my$d = pop; $$d{size} // do{ my $sum = sum( map sz($_), values %{$$d{files}} ); push @sz, $sum if $sum <= 100000; $sum } }
my $used = sz($root);
say "used: $used";
say "Answer: ", sum @sz;
#Answer: 1432936

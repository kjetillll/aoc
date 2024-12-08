use v5.10; use List::Util qw(sum min);
my $root = {name=>'/', parent=>undef};
my $pwd = $root;
while(<>){
    if   ( m,^\$ cd /,     ){ $pwd = $root }
    elsif( m,^\$ cd \.\.,  ){ $pwd = $$pwd{parent} }
    elsif( m,^\$ cd (\S+), ){ $$pwd{files}{$1} //= {name=>$1, parent=>$pwd}; $pwd = $$pwd{files}{$1} }
    elsif( m,^\$ ls,       ){}
    elsif( m,^dir (\S+),   ){ $$pwd{files}{$2}//={name=>$2,parent=>$pwd} }
    elsif( m,^(\d+) (\S+), ){ $$pwd{files}{$2}//={name=>$2,parent=>$pwd,size=>$1} }
    else{die"$. ($_)"}
}
my @sz;
sub sz { my$d = pop; $$d{size} // do{ push @sz, sum( map sz($_), values %{$$d{files}} ); $sz[-1] } }

my $total  = 70000000;
my $need   = 30000000;
my $used   = sz($root);
my $free   = $total - $used;
my $delete = $need - $free;
say "used: $used   free: $free   må delete minst: $delete";
say "Answer: ", min grep { $_ > $delete } @sz;

#Answer: 272298

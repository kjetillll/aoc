use v5.10;
use List::Util qw(sum any);
sub lst { (any{$_}@_) ? ($_[0]-(lst(map{$_[$_]-$_[$_-1]}1..$#_))[0],@_) : (0,@_) }
say sum map { (lst(/-?\d+/g))[0] } <>;

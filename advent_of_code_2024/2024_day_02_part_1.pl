use v5.10;
sub unike { my %sett; grep !$sett{$_}++, @_ }
sub skli { my($s,$w)=@_; map [@$s[$_..$_+$w-1]], 0..@$s-$w }
my %status=qw(-1 D -2 D -3 D 1 U 2 U 3 U); #D=ned U=opp 0=gal diff
say 0+grep join("",unike(map{ $status{ $$_[1] - $$_[0] } || 0 } skli([split],2))) =~ /^[DU]$/, <>;

#359

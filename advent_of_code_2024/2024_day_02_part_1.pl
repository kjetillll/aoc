use v5.10;
sub unike { my %sett; grep !$sett{$_}++, @_ }
sub skli { my($s,$w)=@_; map [@$s[$_..$_+$w-1]], 0..@$s-$w }
my %status=qw(-1 N -2 N -3 N 1 O 2 O 3 O); #N=ned O=opp 0=gal diff
say 0+grep join("",unike(map{ $status{ $$_[1] - $$_[0] } || 0 } skli([split],2))) =~ /^[ON]$/, <>;

#359

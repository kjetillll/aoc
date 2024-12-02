use v5.10;
sub unike { my %sett; grep !$sett{$_}++, @_ }
sub skli { my($s,$w)=@_; map [@$s[$_..$_+$w-1]], 0..@$s-$w }
sub en_fjernet { map{ my @a=@_; splice @a,$_,1; \@a} 0..$#_ }
my %status=qw(-1 D -2 D -3 D 1 U 2 U 3 U); #D=ned U=opp 0=gal diff
say 0+grep{grep{join("",unike(map{ $status{ $$_[1] - $$_[0] } || 0 } skli($_,2))) =~ /^[DU]$/} en_fjernet(split)}<>;

#418

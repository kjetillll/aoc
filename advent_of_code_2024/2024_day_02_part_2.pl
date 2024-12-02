use v5.10;
sub unike { my %sett; grep !$sett{$_}++, @_ }
sub skli { my($s,$w)=@_; map [@$s[$_..$_+$w-1]], 0..@$s-$w }
sub en_fjernet{map{my@a=@_;splice(@a,$_,1);[@a]}0..$#_}
my %status=qw(-1 N -2 N -3 N 1 O 2 O 3 O); #N=ned O=opp 0=gal diff
say 0+grep{grep{join("",unike(map{ $status{ $$_[1] - $$_[0] } || 0 } skli($_,2))) =~ /^[ON]$/} en_fjernet(split)}<>;

#418

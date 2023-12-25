use v5.10;
use List::Util 'sum';
$s=join'',<>;
$s=~/.+/;
$w=1+length$&;
@c=(-$w-1,-$w,-$w+1,-1,1,$w-1,$w,$w+1);
$s=~s{\d+}{$n{$_}{$&}++ for grep substr($s,$_,1)eq'*',grep$_>=0,map$_+pos$s,map{$c=$_;map$c+$_-1,@c}1..length$&}ge;
say sum map{@k=keys%{$n{$_}}; @k-2 ? 0 : $k[0]*$k[1] } keys%n;
__END__
perl -ple'$_=length' 2023_day_3_input.txt |sort|uniq -c #alle linjer har 140 tegn
sum: 82301120 !

use v5.10;
use Acme::Tools qw(srlz);
my $pos=0;
my $id=0;
for(<>=~/\d/g){
    say;
    $c++%2==0?do{push(@files,map[$pos++,$_,$id],1..$_);$id++}:push(@free,map$pos++,1..$_)
}
print srlz(\@files,'files'),"\n";
print srlz(\@free,'free'),"\n\n";

while( $files[-1][0]>$free[0] ){
    $files[-1][0]=shift@free;
    unshift@files,pop@files;
}
print "--\n";
print srlz(\@files,'files'),"\n";
print srlz(\@free,'free'),"\n\n";

$str='.' x @files;
substr($str,$$_[0],1)=$$_[2] for @files;
say "<$str>";
my $sum;$sum+=$$_[0]*$$_[2] for @files;
say "Answer: $sum";

#Answer: 6211348208140

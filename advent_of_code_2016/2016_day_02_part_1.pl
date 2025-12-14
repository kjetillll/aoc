my($x,$y)=(1,1);
my $answer='';
while(<>){
    for(/./g){
        /U/ ? $y-- :
        /D/ ? $y++ :
        /L/ ? $x-- :
        /R/ ? $x++ : die;
        $x=0 if $x<0;
        $x=2 if $x>2;
        $y=0 if $y<0;
        $y=2 if $y>2;
    }
    my $button = 1 + (3*$y + $x);
    $answer .= $button;
}
print "Answer: $answer\n";

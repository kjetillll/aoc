@r=map[/-?\d+/g],<>;
$w=@r==12?11:101; #12 for 2024_day_14_example.txt
$h=@r==12?7:103;
$sek=100;
$q[ do{ #@q uadrants
    my $x = ( $$_[0] + $$_[2] * $sek) % $w;
    my $y = ( $$_[1] + $$_[3] * $sek) % $h;
    $x < $w>>1 && $y < $h>>1 ? 0
   :$x > $w>>1 && $y < $h>>1 ? 1
   :$x < $w>>1 && $y > $h>>1 ? 2
   :$x > $w>>1 && $y > $h>>1 ? 3 : next} ]++ for @r;
print "Answer: ".eval join'*',@q;
#Answer: 225810288

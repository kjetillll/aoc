my @digit = <> =~ /\d/g;

my $disk = join'',
    map sprintf( $_ % 2 ? "s_____" : "f%05d", $_ / 2 ) x $digit[$_],
    0 .. $#digit;

for my $f (map sprintf("f%05d",$_), reverse 0 .. @digit >> 1){
    my($fpos, $file) = $disk =~ /($f)+/ ? ($-[0], $&) : die;
    my $space = "s_____" x ( length($file) / 6 );
    my $spos = $disk =~ /$space/ ? $-[0] : Inf;
    if($fpos > $spos){
        substr($disk, $spos, length$file) = $file;
        substr($disk, $fpos, length$file) = $space;
    }
}

my $sum; $disk =~ s{ f(\d+) }{ $sum += $-[0] / 6 * $1 }gex;
print "Answer: $sum\n";

#time perl 2024_day_09_part_2.pl 2024_day_09_input.txt    "1.43 sec
#Answer: 6239783302560
    

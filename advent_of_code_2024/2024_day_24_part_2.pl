#use strict; use warnings; #no warnings 'recursion';
use v5.10; use List::Util qw(max);
my @inp=map s,\n,,r,<>;

my $eval; sub ev{ my $e=pop()=~s/AND/&/r=~s/XOR/^/r=~s/OR/|/r; $eval.="$e\n" }

my(%wire,%gate,%def,%run);
for(@inp){
    #$wire{$_}=1 for /\b[a-z0-9]{3}\b/g;
    if(/^(\w{3}): ([01])/){
        $wire{$1} = 0+$2;
        ev("\$def{'$1'} = sub { '$1' };");
        ev("\$run{'$1'} = sub { \$wire{'$1'} // die };");
    }
    elsif(/^(\w{3}) (AND|OR|XOR) (\w{3}) -> (\w{3})$/){
        $gate{$4}=1;
       #ev("\$def{'$4'} = sub {   '('.join('$2', sort \$def{'$1'}->(), \$def{'$3'}->() ).')' };");
        ev("\$def{'$4'} = sub {   join(' ', '$2', sort(\$def{'$1'}->(), \$def{'$3'}->())) };");
        ev("\$run{'$4'} = sub { \$run{'$1'}->() $2 \$run{'$3'}->() };");
    }
    else{/\S/&&die}
}
say "wire count: ".keys(%wire)."   gate count: ".keys(%gate);
#$eval = join("",map"sub $_;\n",sort keys%w) . $eval;
#say srlz(\%wire,'wire','',1);
#say ++$ln.": $_" for $eval=~/.+/g;#exit;
eval $eval; die if $@;
my $bin = join"",map $run{$_}->(), grep exists $run{$_}, reverse 'z00'..'z45';;
say "bin: $bin";
say "Answer part 1: ", oct("0b$bin"); die if oct("0b$bin") != 51745744348272; #exit;

sub err {
    my(%missing,%weird);
    for my $g ('z00'..'z45'){
        my $def = $def{$g}->();
        #die"$g: $def" if $g eq 'z31';
        my $n = $g=~/\d+/ ? $& : die;
        die $g if length($n)<2;
        if($n != 45){
            my @s="00".."$n";
            #say"n: $n   g: $g   s: @s";
            $def !~ /x$_/ and push @{$missing{$g}}, "x$_" for @s;
            $def !~ /y$_/ and push @{$missing{$g}}, "y$_" for @s;
            #say "@s";
            @s=grep$_ gt $n, "00".."44";
            $def =~ /x$_/ and push @{$weird{$g}}, "x$_" for @s;
            $def =~ /y$_/ and push @{$weird{$g}}, "y$_" for @s;
        }
    }
    (\%missing,\%weird)
}
my $answer;
sub swap { @def{@_} = @def{reverse@_}; @run{@_} = @run{reverse@_}; $answer=join",",sort(@_,split",",$answer) }

# my @swap;
# #for("z00".."z45"){
# #for("z01"){
# for(sort keys%gate){ #next;
#     swap('z31',$_);
#     my($mi,$we)=err($_);
#     swap('z31',$_);
#     push @swap, $_ if !keys(%$mi) and !keys(%$we);
#     #say srlz($mi,'missing','',1);
#     #say srlz($we,'weird','',1);
# }
# #say srlz(\@swap,'swap');exit; #@swap=('hkh','rjt');

#my($a,$b,$c)=(11745744348271,40000000000001,51745744348272); die if $a+$b!=$c;
my($a,$b,$c)=(11745744348271,11745744348271,2*11745744348271); die if $a+$b!=$c;
@wire{reverse"x00".."x44"}=map 0+$_,split//,sprintf("%045b",$a);
@wire{reverse"y00".."y44"}=map 0+$_,split//,sprintf("%045b",$b);

sub say_zdefs{say "def $_: " . do{ my $d=$def{$_}->(); sprintf"len: %3d   %s",length($d),$d=~s/^(.{120}).*(.{120})$/$1...$2/r} for "z00".."z45"}
say_zdefs;


my $z= oct "0b".join"",map $run{$_}->(), grep exists $run{$_}, reverse 'z00'..'z45';
printf"a: %045b\n",$a;
printf"b: %045b\n",$b;
printf"z:%046b\n",$z;

srand(7);

#-- best so far: z18 hmt, z27 bfq, z31 hkh

# #swap('z31','hkh');
# #swap('z31','rjt');
 swap('z18','hmt');  #found by looking at or's, and's and xor's needed for each zNN
# swap('z19','nts');
 swap('z27','bfq');  #same
# swap('z28','mcb');
 swap('z31','hkh');  #same
# #swap('z39','hsf');
# #swap('z39','tkf');
swap('bng','fjp');   #saw swap in "polish notation" (PN, not RPN...) of the then gate expressions, the last 'def z00-z45' section, not the first, for first and last of def z39 and def z40 accordingly, comment away this swap to see this
    
my %err;
for(1..400){
    my($x,$y)=map int(rand 1<<45),1..2;
    @wire{reverse"x00".."x44"}=map 0+$_,split//,sprintf("%045b",$x);
    @wire{reverse"y00".."y44"}=map 0+$_,split//,sprintf("%045b",$y);
    my $z = oct "0b".join"",map $run{$_}->(), grep exists $run{$_}, reverse 'z00'..'z45';
    my $f = $x + $y;
    my($zbits,$fbits)=map sprintf("%046b",$_),$z,$f;
    my $err=join'', map {my$e=substr($zbits,$_,1) ne
                              substr($fbits,$_,1); $err{45-$_}++ if $e; $e ? '^' : ' ' } 0..45;
#    my $err=join'',map{$err{$_}?'^':' '}reverse 0..45;
    printf"$$_[0]: %046b  = %15d\n",$$_[1],$$_[1] for ['x',$x],['y',$y],['z',$z],['f',$f];
    print "   $err\n";
}
sub info{
    my $g=shift;
    my $d=$def{$_}->();
    my $l=length$d;
    my %ant; $ant{$_}=$d=~s/ \Q$_\E /$_/g for '|','&','^';
    my($o,$a,$x) = @ant{'|','&','^'};
    my $s = $o==$x-2 && $o*2+1==$a ? '*':' ';
    ( str=>sprintf("%s: $s  len: %4d   or: %3d   and: %3d   xor: %3d\n", $g, $l, @ant{'|','&','^'}), def=>$d, len=>$l, %ant )
}

print for sort map sprintf("%14d <-- %s",@$_[1,0]),
sort{ $$a[1] <=> $$b[1] }
map{
    my %i=info($_);
    my($o,$a,$x) = @i{'|','&','^'};
    #die("o: $o   a: $a   x: $x   $i{str}") if $a>10;
    my $s = $o==$x-2 && $o*2+1==$a ? '*':' ';
    #die"s: $s   $o/$a/$x" if $_ eq 'hmt';
    [ "$s ".($i{str}=~s/ 0/  /gr), $i{'|'}*1e8 + $i{'&'}*1e4 + $i{'^'} ]
}
#grep!/^[xyz]\d\d$/,
keys %def;

my @g=grep!/^[xy]\d\d$/,sort keys %gate;
#die"<@g>";
sub random{$_[0][rand@{$_[0]}]}

my $has_err=0;
while(1){
    #my($a,$b)=map random(\@g),1,2;
    my($a,$b)=('z39',random(\@g)); next if $b eq 'wgm';next if $b eq 'qfw';
    next if $a eq $b;
    next if "$a $b" eq 'wgm qfw';
    next if "$a $b" eq 'wgm cvp';
#    swap($a,$b);
    say "swaps $a and $b";
    my $infotab=join"", map{
        my %i=info($_);
        $i{str}=~s/len:/sprintf"err: %6d   lendiff: %4d   $&", $err{s|^z0?||r}, $i{len}-$last/e;
        $last=$i{len};
        $i{str}=~s/ 0/  /gr;
    }
    "z00".."z45";
    print $infotab;
    my $s=$infotab=~s/\*/*/g;
    print "infotab *: $s   a: $a   b: $b\n";
    $has_err=1 if $infotab=~/err: +\d/;
#   swap($a,$b);
    last;
}

#print srlz(\%wire,'wire');

say_zdefs;
say "Ferdig. ".(time-$^T)."s";
say "Answer: $answer" if !$has_err;
exit;
#say "Answer: ".oct("0b".join"",map &$_(), reverse sort grep/^z/,keys%wire);
# Answer: 51745744348272

# 00-17, 24-26, 37-38, 
sub ors{my$z=pop;max($z-1,0)} sub ands{my$z=pop;max(2*$z-1,0)} sub xors{my$z=pop;$z+1}

__END__

perl 2024_day_24_part_2.pl 2024_day_24_input.txt | less

        bfq,bng,fjp,hkh,hmt,z18,z27,z31
Answer: bfq,bng,fjp,hkh,hmt,z18,z27,z31

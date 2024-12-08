use v5.10;
my @s;
while(<>){
    if( my($n,$from,$to) = /move (\d+) from (\d) to (\d)/ ){
	push @{$s[$to]}, splice @{$s[$from]}, -$n
    }
    else { #put A-Z's into the @s stacks
	//;
	/(\d)([A-Z])/ and unshift @{ $s[ $1 ] }, $2 for map $_.substr($',$_*4-3,1), 1..9;
    }
}

say @$_ for @s;

say "Answer: ", map pop @$_, @s;

__END__

Run:

perl 2022_day_05_part_2.pl 2022_day_05_input.txt

Output:

GCMBF
VMWQS
BTSCZ
SBMDJW
WQFWNGFGNTGHTJPQB
P
ZCTPSHJMT
NTVB
LSHG
Answer: FSZWBPTBG

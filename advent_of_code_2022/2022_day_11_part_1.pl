use v5.10;

my @monkey = map{
    my %m; @m{qw(items operation div_by to_true to_false)} = @$_;
    $m{items} = [ $m{items} =~ /\d+/g ];
    s/\D//g for @m{qw(div_by to_true to_false)};
    \%m
  }
  map [ /.+[=:]\s+(.+)/g ],
  split /\n\n/,
  join('',<>);

for my $round (1..20){
    for my $i (0 .. $#monkey){
        say "Monkey $i:";
        my $m = $monkey[$i];
        while( @{ $$m{items} } ){
            my $old = shift @{ $$m{items} };
            say "  Monkey inspects an item with a worry level of $old";
            $$m{inspected}++;
            my $op = $$m{operation}=~s/[a-z]+/\$$&/gr;
            my $new = eval $op;
            say "    Worry level is '$op' to $new";
            $new = int($new/3);
            my $what = $new % $$m{div_by}==0 ? "is" : "is not";
            say "    Monkey gets bored with item. Worry level is divided by 3 to $new";
            say "    Current worry level $what divisible by $$m{div_by}.";
            my $to = $new % $$m{div_by} == 0 ? $$m{to_true} : $$m{to_false};
            say "    Item with worry level $new is thrown to monkey $to.";
            push @{$monkey[$to]{items}}, $new;
        }
    }
    say "After round $round, the monkeys are holding items with these worry levels:";
    say "Monkey $_: @{$monkey[$_]{items}}" for 0 .. $#monkey;
}

say "Answer: ", eval join '*', (sort {$b<=>$a} map $$_{inspected}, @monkey)[0,1];

#time perl 2022_day_11_part_1.pl 2022_day_11_input.txt   #0.04 sec
#Answer: 58322

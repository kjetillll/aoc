use v5.10;
@t=<>=~/\d+/g;
@d=<>=~/\d+/g;
for$t(@t){
    say"t: $t";
    my@way;
    my$d=shift@d;
    for$s(1..$d){
	push@way,$s*($t-$s);
    }
    @way=grep{$_>$d}@way;
    say "@way\n";
    push@ws,0+@way;
}
say"ways: @ws";
say eval join'*',@ws;

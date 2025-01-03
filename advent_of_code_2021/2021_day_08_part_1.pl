use v5.10;
say "Answer: ",
    0+
    map{ grep length()=~/[2437]/, /\w+/g }
    map s/.*\|//gr,
    <>;

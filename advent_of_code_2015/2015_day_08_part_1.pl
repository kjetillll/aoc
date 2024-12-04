while(<>){
    s/\s//g;
    $code += length;
    $chars += length eval;
}
print "Answer: ", $code - $chars, "\n";

#Answer: 1342

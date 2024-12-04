print "Answer: ", reverse "\n",
    eval
    join '+',
    map { /(\d+),(\d+)/; $1 * $2 }
    grep { /do/ and $disabled=/don't/; /mul/ and !$disabled }
    map / mul\(\d+,\d+\) | do\(\) | don't\(\) /gx,
    <>

#Answer: 108830766

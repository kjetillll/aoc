print "Answer: ", reverse "\n",
    eval
    join '+',
    map /(\d+),(\d+)/ && $1 * $2,
    grep !( /don't/ .. /do\(/ ) && /mul/,
    map / mul\(\d+,\d+\) | do\(\) | don't\(\) /gx,
    <>

#Answer: 108830766

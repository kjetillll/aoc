import re, sys
with open(sys.argv[1]) as f:
        lines = [ re.findall( r'\d+', line ) for line in f ]
timer = {}
for t in map( int, lines[0] ):
    timer[t] = timer.get(t,0) + 1
for day in range(256):
    timer_next = {}
    for t in timer:
        n = 7 if t == 8 else (t-1) % 7
        timer_next[n] = timer_next.get(n,0) + timer[t]
    timer_next[8] = timer.get(0,0)
    timer = timer_next
    if   day == 80-1:
        print("Answer part 1: ", sum(timer.values()))
    elif day == 256-1:
        print("Answer part 2: ", sum(timer.values()))

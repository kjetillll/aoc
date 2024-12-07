$/="\n\n";                   #makes <> read paragraphs instead of lines
print "Answer: ",            #output answer
    eval join '+',           #add top 3
    (                        #find top 3
     sort{$b<=>$a}           #...by sorting earch elves calories
     map eval s/\d+/+$&/gr,  #add calories of each elf by placing a + infront of each number and eval the summation list
     <>                      #read input as a list of elements consiting of each elf's caliries list
    )[0,1,2]                 #pick only top 3 from the now sorted list

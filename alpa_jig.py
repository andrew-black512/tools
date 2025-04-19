import re
filename = "jigclue.txt"
with open(filename) as clue_file :
    for l in clue_file :
        print(l) 
        
        
        match= re.search( r"\((.*)\)", l )
        if match :
            lengths = match.group(1)
            size = 0
            for s in lengths.split(',') :
               print(f"  {s}") 
               size += int(s)
            print (f" {size}")

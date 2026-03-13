"""
Takes a file jogclue.txt extracted from PDF file for a 
jigsaw crossword.

TODO
- use a better regexp (re module)
- This adds numbers - make configurable whether to use numbers or letters from file.
- join lines that dont end in ( )

consider different outputs - clues with lengths
"""
import re
filename = "jigclue.txt"

my_dict = {} 
   # Stores the clues for each length
   # { 4: [1, 3], 
   #   8: [2, 8] }
clue_no = 1
def find_bracket(l):
    match= re.search( r"\((.*)\)", l )
    return match

with open(filename) as clue_file :
    for l in clue_file :
        #print(l) 
        
        
        match = find_bracket(l)
        if match :
            lengths = match.group(1)
            size = 0
            # CLUe might be "4,5" and we need 14
            for s in lengths.split(',') :
               #print(f"  {s}") 
               size += int(s)
            #print (f" {size}")
            if size in my_dict:
               my_dict[size].append(clue_no )
            else:
               my_dict[size] = [clue_no]
        clue_no += 1
print(my_dict)
ct = 0
for l in sorted(my_dict):
    print(l)
    clue_list = my_dict[l]
    for clue in clue_list:
        print (f"   ,{clue}" )
        ct += 1
    count_this_len = count(clue_list)
    print  (f"   ,ct leng=,{count_this_len}" )
print ( f"ct = {ct}")
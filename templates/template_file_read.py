#!/usr/bin/python3
import re
import sys

#----------------------------------------------------------
# arguments
filename = sys.argv[1]

with open(filename) as fh :
  for line in fh:
    linec = line.rstrip() 
    print (linec,end='\t')

print () 


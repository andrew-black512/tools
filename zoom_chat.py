#!/usr/bin/python3
import argparse
import sys
import re

# arguments are in the order of [open]VMS SEARCH not grep
filename = sys.argv[1]
search_string = sys.argv[2]
with open(filename) as fh :
  for line in fh:
    if re.search (search_string,line) :
        line = line.rstrip()
        print (line)

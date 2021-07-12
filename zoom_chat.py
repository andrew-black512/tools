#!/usr/bin/python3
import argparse
import sys
import re

# arguments are in the order of [open]VMS SEARCH not grep
filename = sys.argv[1]
with open(filename) as fh :
  for line in fh:
    time = line[0:8]
    text = line[14:]  # Ignores the 'From '  TODO split on :
    line = line.rstrip()
    print (text)

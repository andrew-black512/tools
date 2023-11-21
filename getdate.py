#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

# abs makes -n same as n (as in find -mtime)
numargs = len(sys.argv)-1
if numargs >= 1:
    earlier =  int(sys.argv[1])
else:
    earlier = 0 

now = datetime.now()

earlier_date = now - timedelta(earlier)
et = earlier_date.strftime("%Y-%m-%d ")

print (et)

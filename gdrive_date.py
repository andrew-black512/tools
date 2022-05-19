#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

# abs makes -n same as n (as in find -mtime)
earlier = abs(int(sys.argv[1]))
if len(sys.argv)-1 >= 2:
    print('2 args')
    later = abs(int(sys.argv[2]))
else:
    later = -1
now = datetime.now()

earlier_date = now - timedelta(earlier)
et = earlier_date.strftime("after:%Y-%m-%d ")
#if ??????? 
later_date = now - timedelta(later)
lt = later_date.strftime("before:%Y-%m-%d ")
lt = ''

print (et+lt)

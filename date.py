#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

if len(sys.argv) == 1 :
  offset = 0
else :
  offset = int(sys.argv[1])

now = datetime.now()

later_date = now + timedelta(offset)
lt = later_date.strftime("%Y-%m-%d ")
print (lt)

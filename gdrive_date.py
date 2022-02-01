#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

earlier = int(sys.argv[1])
now = datetime.now()
earlier_date = now - timedelta(earlier)
print (earlier_date.strftime("after:%Y-%m-%d") )
#print (x)

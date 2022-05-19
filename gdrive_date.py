#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

earlier = int(sys.argv[1])
later = int(sys.argv[2])
now = datetime.now()

earlier_date = now - timedelta(earlier)
et = earlier_date.strftime("after:%Y-%m-%d ")
later_date = now - timedelta(later)
lt = later_date.strftime("before:%Y-%m-%d ")
print (et+lt)

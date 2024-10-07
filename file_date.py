#!/usr/bin/python3
import argparse
import sys
from datetime import timedelta,datetime

numargs = len(sys.argv)-1
if numargs >= 1:
    #number of days forward - default today
    earlier = int(sys.argv[1])
else:
    earlier = 0  ### prefer to say None or nil
now = datetime.now()
prefix="DF "   # TODO

earlier_date = now + timedelta(earlier)
et = earlier_date.strftime("DF %d-%m-%Y ")
#if ???????

print (et)
# TODO - send to clipboard
# TODO - also send full date to sysout

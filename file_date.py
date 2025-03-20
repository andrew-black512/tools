#!/usr/bin/env python3

import argparse
import sys
from datetime import timedelta,datetime
import clipboard


def put_clipboard(txt):
    print( F"CLIP:{txt}")
    clipboard.copy(txt)
    return 0
    

prefix = 'DF' 
numargs = len(sys.argv)-1
if numargs >= 1:
    #number of days forward - default today
    earlier = int(sys.argv[1])
    if numargs >= 2:
        prefix = sys.argv[2]
else:
    earlier = 0  ### prefer to say None or nil
    print("""
          file_date.py  offset [prefix]
            offset 0= today, +ve future
          """
          ) 
    exit
now = datetime.now()

earlier_date = now + timedelta(earlier)
et = earlier_date.strftime("%d-%m-%Y ")
text = F"{prefix} {et}"


put_clipboard (text)
# TODO - send to clipboard
# TODO - also send full date to sysout

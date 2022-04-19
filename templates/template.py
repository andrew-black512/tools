#!/usr/bin/python3

import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--width", "-w", help="set output width")
parser.add_argument("--version","-v")
parser.add_argument("--exa_boolean", "-b", help="a boolean", action="store_true")
args = parser.parse_args()
print ( args )

if args.width:
    print("Set output width to %s" % args.width)

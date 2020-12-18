#!/bin/sh
NAME=$1
FILE=~/work/meetings/$NAME

xclip -o >> $FILE
echo >> $FILE

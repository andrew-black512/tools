#!/bin/sh
#TODO - if no argument - default or refuse. Could be used from a keypress with no change to add name

NAME=$1
FILE=$MEET/$NAME



echo ======================== >> $FILE
echo "   Saved" $( date +"%a %b %d") >> $FILE

xclip -o >> $FILE
echo >> $FILE

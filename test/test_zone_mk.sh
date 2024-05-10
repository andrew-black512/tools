cd testzone
rm 202*/*
rmdir 202*

touch jan.txt -d "10-jan"
 
 touch nov.txt -d "1-nov"
 touch novaa.txt -d "1-nov"
 touch dec.txt -d "1-dec"
 
 touch feb.txt -d "1-feb"

tree
zonify.rb "*.txt" week_%U
tree

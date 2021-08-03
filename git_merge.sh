#/bin/bash
FROM=$1
INTO=$2 # TODOOptional - to add
#  - find common base of commit


git checkout master
git commit --allow-empty --allow-empty-message -m ''

echo <<EOS

Insert a description as first line followed by blank.

EOS

read -s -p "RETURN to continue" v
echo "v=$v"

git merge $FROM

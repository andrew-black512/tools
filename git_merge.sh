#/bin/bash
FROM=$1   # Arguably could be the current branch (ie one you have bveen editing)
INTO=$2 # TODO Optional - to add
#  - find common base of commit (usaully develop or mater)


git checkout master
git commit --allow-empty --allow-empty-message -m ''

cat <<EOS

This covers basic merging, done to get me to do if often.
If need be rework for other cases.

Insert a description as first line followed by blank.

EOS

read -s -p "RETURN to continue" v
echo "v=$v"

git merge $FROM

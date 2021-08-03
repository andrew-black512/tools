
git checkout master
git commit --allow-empty --allow-empty-message

echo <<EOS

Insert a description as first line followed by blank.

EOS

sleep 1
exit

git merge $FROM

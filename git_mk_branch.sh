TAGNAME=to_stable_$(date +"%Y_%m_%d" )
echo tag=$TAGNAME
git tag -f $TAGNAME HEAD

cd /home/andrew/dev/trainsstable
echo
git pull origin master
echo
git log -n 10  --oneline --decorate
echo

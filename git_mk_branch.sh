# d22_03_21_live
TOPIC=$1
DESC=$2
BRNAME=d$(date +"%y_%m_%d" )_$TOPIC
echo tag=$BRNAME

git checkout -b $BRNAME

git branch --edit-description

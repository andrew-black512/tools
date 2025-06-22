  # TODO add option A
  SAFE=~/safe/gitbackups/
  #unzip -o /home/andrew/Downloads/dl_2022/umap_backup_complete.zip 
  mv -v --backup=numbered \
    /home/andrew/Downloads/dl_2022/$FILE  -t $SAFE
  ls $SAFE -lrt
  
  git status
  git add $FILE
  git commit
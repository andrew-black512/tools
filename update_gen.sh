  # TODO add option A
  SAFE=~/safe/umapbackup/
  unzip -o /home/andrew/Downloads/dl_2022/umap_backup_complete.zip 
  mv -v --backup=numbered \
    /home/andrew/Downloads/dl_2022/umap_backup_complete.zip  -t $SAFE
  ls $SAFE
  
  git status
  git add *.umap
  git commit
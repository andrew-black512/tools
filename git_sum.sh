 echo Unmerged:
 git branch --no-merged master
 echo
 echo Merged:
 git branch --merged master
 echo
 echo Stashes:
 git stash list

 git status --untracked-files=no

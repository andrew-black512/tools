#Info: lists branches (merged and unmerged). stashes and status

 echo Unmerged:
 git branch --no-merged master
 echo
 echo Merged:
 git branch --merged master
 echo
 echo Stashes:
 git stash list

 git status --untracked-files=no

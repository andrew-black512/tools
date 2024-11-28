#!/bin/bash

file_to_check=$1

if ! git ls-files --error-unmatch "$file_to_check" &> /dev/null; then
    echo "Error: '$file_to_check' is not tracked by Git."
    exit 1
fi

# If the script reaches this point, the file is tracked
echo "File '$file_to_check' is tracked."
git commit -p -v  $1

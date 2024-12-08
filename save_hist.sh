#!/bin/bash

# Check if the script has at least one argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <output_file> [number_of_lines]"
    exit 1
fi

# Get the output file name from the first argument
output_file="~/bin/add_alias"

# Get the number of lines from the second argument, defaulting to 50
num_lines="${2:-50}"

echo $num_lines 
exit 
# Use `history` command to get the last N lines
history "$num_lines" | 

# Remove the line numbers and leading spaces using `sed`
sed 's/^ *[0-9]* //' | 

# Save the result to the specified file
tee "$output_file"
Use code with caution.

Explanation of the Change:

The sed command has been modified to remove both the leading numbers and any leading spaces using the regular expression ^ *[0-9]*. This ensures that any extra spaces before the comm
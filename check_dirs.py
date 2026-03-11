import csv
import os
import sys

def check_directories(file_path, col_number):
    # Convert 1-based input to 0-based index
    col_index = col_number - 1
    missing_count = 0
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            # quotechar='"' handles the quotes in your sample perfectly
            reader = csv.reader(f, delimiter=' ', quotechar='"')
            
            for line_num, row in enumerate(reader, 1):
                if not row: 
                    continue
                
                try:
                    path_to_check = row[col_index]
                    
                    if not os.path.isdir(path_to_check):
                        print(f"Line {line_num}: MISSING -> {path_to_check}")
                        missing_count += 1
                        
                except IndexError:
                    print(f"Line {line_num}: Error - Column {col_number} does not exist.")

        if missing_count == 0:
            print(f"Check complete: All paths in column {col_number} exist.")
        else:
            print(f"\nTotal missing directories: {missing_count}")

    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")

if __name__ == "__main__":
    # Ensure the user provided the right number of arguments
    if len(sys.argv) != 3:
        print("Usage: python check_dirs.py <filename> <column_number>")
        print("Example: python check_dirs.py data.txt 3")
    else:
        filename = sys.argv[1]
        try:
            column = int(sys.argv[2])
            check_directories(filename, column)
        except ValueError:
            print("Error: Column number must be an integer.")
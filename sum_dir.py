import os
import argparse
import sys

def summarize_directories(root_dir, output_file=None, sort_by='name'):
    """Lists directories in a given path and summarizes the number of files and subdirectories within each, with sorting.

    Args:
        root_dir (str): The path to the directory to analyze.
        output_file (str, optional): Path to the output file. Defaults to None (stdout).
        sort_by (str, optional): The criteria to sort directories by ('name', 'files', 'subdirs'). Defaults to 'name'.
    """
    directory_data = []
    total_files = 0
    total_subdirs = 0
    output_stream = sys.stdout if output_file is None else open(output_file, 'w')

    for item in os.listdir(root_dir):
        item_path = os.path.join(root_dir, item)
        if os.path.isdir(item_path):
            subdir_files = 0
            subdir_count = 0
            for sub_item in os.listdir(item_path):
                sub_item_path = os.path.join(item_path, sub_item)
                if os.path.isfile(sub_item_path):
                    subdir_files += 1
                elif os.path.isdir(sub_item_path):
                    subdir_count += 1
            directory_data.append({'name': item, 'files': subdir_files, 'subdirs': subdir_count})
            total_files += subdir_files
            total_subdirs += subdir_count

    if sort_by == 'name':
        sorted_data = sorted(directory_data, key=lambda x: x['name'])
    elif sort_by == 'files':
        sorted_data = sorted(directory_data, key=lambda x: x['files'])
    elif sort_by == 'subdirs':
        sorted_data = sorted(directory_data, key=lambda x: x['subdirs'])
    else:
        print(f"Warning: Invalid sort option '{sort_by}'. Sorting by name.")
        sorted_data = sorted(directory_data, key=lambda x: x['name'])

    print(f"{os.path.abspath(root_dir)} ")
    for data in sorted_data:
        print(f"    {data['name']:<20} {data['files']:<6} {data['subdirs']:<6}", file=output_stream)

    print(f"{'total':<20} {total_files:<6} {total_subdirs:<6}", file=output_stream)

    if output_file is not None:
        output_stream.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Summarize files and subdirectories within directories with sorting.")
    parser.add_argument("directory", help="The root directory to analyze.")
    parser.add_argument("--out", default=None, help="Optional output file path. Defaults to stdout.")
    parser.add_argument("--sort", choices=['name', 'files', 'subdirs'], default='name', help="Sort output by 'name', 'files', or 'subdirs'. Defaults to 'name'.")
    args = parser.parse_args()

    summarize_directories(args.directory, args.out, args.sort)
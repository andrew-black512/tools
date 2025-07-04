#!/usr/bin/env python3

import os
import re
import argparse

def process_filename(filename, prefix=None, suffix=None):
    """
    Applies the renaming rules and adds prefix/suffix to a single filename.
    Returns the new filename.
    """
    name, ext = os.path.splitext(filename)

    # Rule 1: Replace one or more spaces or '(' with '_'
    new_name = re.sub(r'[ (\-_]+', '_', name)

    # Rule 2: Delete ')'
    new_name = new_name.replace(')', '')

    # Add prefix if provided
    if prefix:
        new_name = f"{prefix}-{new_name}"

    # Add suffix if provided
    if suffix:
        new_name = new_name + suffix

    return new_name + ext

def main():
    parser = argparse.ArgumentParser(
        description="Rename files based on specific rules, with optional prefix and suffix.",
        epilog="Example: python rename_files_cli.py --prefix 'new_' --suffix '_v2' *.txt"
    )
    parser.add_argument(
        'files',
        metavar='FILE',
        nargs='+',
        help='One or more files to rename. Use shell expansion like *.txt, *.jpg, etc.'
    )
    parser.add_argument(
        '--prefix',
        type=str,
        help='Add a string prefix to the new filename.'
    )
    parser.add_argument(
        '--suffix',
        type=str,
        help='Add a string suffix to the new filename before the extension.'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Show what would be renamed without actually performing the rename operation.'
    )

    args = parser.parse_args()

    print("\n--- File Renamer Program (CLI) ---")
    if args.dry_run:
        print("!!! DRY RUN MODE: No files will be actually renamed. !!!\n")

    files_processed = 0
    files_would_be_renamed = 0

    for filepath in args.files:
        files_processed += 1
        directory, filename = os.path.split(filepath)

        if not os.path.exists(filepath):
            print(f"Warning: '{filepath}' not found or does not exist. Skipping.")
            continue
        if os.path.isdir(filepath):
            print(f"Warning: '{filepath}' is a directory. Skipping.")
            continue

        original_filename = filename
        new_filename = process_filename(original_filename, args.prefix, args.suffix)

        if new_filename != original_filename:
            new_filepath = os.path.join(directory, new_filename)
            print(f"Would rename '{original_filename}' to '{new_filename}'")
            if not args.dry_run:
                try:
                    os.rename(filepath, new_filepath)
                    print(f"  --> Renamed '{original_filename}' to '{new_filename}'")
                    files_would_be_renamed += 1
                except OSError as e:
                    print(f"Error renaming '{original_filename}': {e}")
            else:
                files_would_be_renamed += 1
        else:
            print(f"'{original_filename}' already conforms to rules (and no prefix/suffix change), no rename needed.")

    print(f"\n--- Summary ---")
    print(f"Files processed from command line: {files_processed}")
    if args.dry_run:
        print(f"Files that would be renamed: {files_would_be_renamed}")
    else:
        print(f"Files actually renamed: {files_would_be_renamed}")

if __name__ == "__main__":
    main()
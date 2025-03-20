#!/usr/bin/env python3

import argparse

def print_first_n_lines(filename, N):
    """Prints the first N lines of a file, prepended with the filename.

    Args:
        filename: The name of the file to process.
        N: The number of lines to print.
    """

    try:
        with open(filename, 'r') as f:
            print(f"{filename}:")
            lines = f.readlines()[:N]
            for line in lines:
                print(f"   {line}", end='')
            print("")
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")

def main():
    parser = argparse.ArgumentParser(description='Print the first N lines of each file.')
    parser.add_argument('-N', type=int, default=5, help='Number of lines to print')
    parser.add_argument('files', nargs='+', help='Files to process')

    args = parser.parse_args()

    for filename in args.files:
        print_first_n_lines(filename, args.N)

if __name__ == '__main__':
    main()
    
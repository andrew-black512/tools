#!/usr/bin/env python3

import json
import argparse
""" Sumaries a VSC template file"""

def walk_data(data) :
    for snip_key in data :
        scdata = data[snip_key]
        print(f"    {scdata['prefix']:10} {snip_key:30} {scdata['description']} ")

def reformat_json_file(input_filepath):
    """
    Reads a JSON file, reformats it with indentation for better readability,
    and writes the formatted JSON to a new file.

    Args:
        input_filepath (str): The path to the input JSON file.
    """
    try:
        with open(input_filepath, 'r') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Input file not found at {input_filepath}")
        return
    except json.JSONDecodeError as e:
        print(f"Error: Could not decode JSON from {input_filepath}. ")
        print(f"Error position: line {e.lineno}, column {e.colno}")
        return
    print(f"  {input_filepath} ")
    walk_data(data)
    print(f"")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Reformat a JSON file for better readability.")
    parser.add_argument("input", nargs="+", help="Path to the input JSON file.")
    
    args = parser.parse_args()

    for filename in args.input :
        reformat_json_file( filename )
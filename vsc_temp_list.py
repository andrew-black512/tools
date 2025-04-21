#!/usr/bin/env python3

import json
import argparse

def walk_data(data) :
    for x in data :
        print()
        scdata = data[x]
        print(f" {scdata['prefix']:20}  {scdata['description']} ")


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
    except json.JSONDecodeError:
        print(f"Error: Could not decode JSON from {input_filepath}. Please ensure it's a valid JSON file.")
        return

    walk_data(data)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Reformat a JSON file for better readability.")
    parser.add_argument("input", help="Path to the input JSON file.")
    
    args = parser.parse_args()

    reformat_json_file(args.input )
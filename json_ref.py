import json
import argparse

def reformat_json_file(input_filepath, output_filepath, indent=4):
    """
    Reads a JSON file, reformats it with indentation for better readability,
    and writes the formatted JSON to a new file.

    Args:
        input_filepath (str): The path to the input JSON file.
        output_filepath (str): The path to the output JSON file.
        indent (int, optional): The number of spaces to use for indentation. Defaults to 4.
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

    try:
        with open(output_filepath, 'w') as f:
            json.dump(data, f, indent=indent)
        print(f"Successfully reformatted JSON and wrote to {output_filepath}")
    except IOError:
        print(f"Error: Could not write to output file at {output_filepath}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Reformat a JSON file for better readability.")
    parser.add_argument("input", help="Path to the input JSON file.")
    parser.add_argument("output", help="Path to the output JSON file.")
    parser.add_argument("-i", "--indent", type=int, default=4,
                        help="Number of spaces to use for indentation (default: 4).")

    args = parser.parse_args()

    reformat_json_file(args.input, args.output, indent=args.indent)
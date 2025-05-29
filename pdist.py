#!/usr/bin/env python3

import readline
import argparse
import os
import sys # Import sys for checking if stdin is a TTY (optional, but good practice for interactive input)

def write_to_file(filepath, text, mode='w'):
    """
    Writes the given text to the specified file path.

    Args:
        filepath (str): The full path to the file to write to.
        text (str): The text content to write.
        mode (str): The file open mode. 'w' for write (overwrite), 'a' for append.
                    Defaults to 'w'.
    """
    try:
        # Ensure the directory exists before attempting to write
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        with open(filepath, mode, encoding='utf-8') as f:
            f.write(text)
    except IOError as e:
        print(f"Error writing to file '{filepath}': {e}")

def read_file_content(filepath):
    """
    Reads and prints the content of the specified file path.

    Args:
        filepath (str): The full path to the file to read.
    """
    try:
        if not os.path.exists(filepath):
            print(f"File '{filepath}' does not exist.")
            return

        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            print(f"\n--- Content of '{filepath}' ---")
            print(content)
            print(f"--- End of '{filepath}' content ---")
    except IOError as e:
        print(f"Error reading file '{filepath}': {e}")

def main():
    """
    Parses command-line arguments and calls the appropriate functions.
    """
    parser = argparse.ArgumentParser(
        description="Write text to a named file with various options.",
        formatter_class=argparse.RawTextHelpFormatter # Allows for newlines in help text
    )

    parser.add_argument(
        "file",
        help="The name of the file to write to. Will be placed in the notes directory."
    )
    parser.add_argument(
        "text",
        nargs='*', # Allows zero or more arguments for text, which will be joined
        help="The text content to write to the file. Enclose in quotes if it contains spaces. "
             "If no text is provided, the script will prompt for interactive input."
    )
    parser.add_argument(
        "-a", "--append",
        action="store_true",
        help="Explicitly append the text to the file. (Default if file exists)"
    )
    parser.add_argument(
        "-p", "--print",
        action="store_true",
        help="Print the content of the file after writing."
    )
    parser.add_argument(
        "-c", "--clear",
        action="store_true",
        help="Clear the file before writing. This option overrides --append and --new."
    )
    parser.add_argument(
        "-d", "--delete",
        action="store_true",
        help="Delete the file. If this option is used, no text will be written."
    )
    parser.add_argument(
        "-n", "--new",
        action="store_true",
        help="Create a new file if it doesn't exist. Without this, an error occurs if file is not found."
    )
    parser.add_argument(
        "--notes-dir",
        default=os.path.join(os.path.expanduser("~"), "notes"), # Default to ~/notes
        help="Specify the base directory for notes. Defaults to '~/notes/'."
    )
    parser.add_argument(
        "-e", "--edit",
        nargs="?",  # Makes the argument optional, and if present, the value is optional
        const="gedit",  # Value if --edit is present but no value is given (e.g., --edit)
        default=None,  # Default value if --edit is not present at all
        help="Specify an editor. Defaults to 'gedit'"
    )

    args = parser.parse_args()

    # Construct the full file path using the specified (or default) notes directory
    notes_directory = args.notes_dir
    # Ensure the directory exists before attempting any file operations within it
    try:
        os.makedirs(notes_directory, exist_ok=True)
    except OSError as e:
        print(f"Error creating notes directory '{notes_directory}': {e}")
        return

    filepath = os.path.join(notes_directory, args.file)

    if args.print:
        read_file_content(filepath)
        return # having printed without asking for input
    if args.edit:
        print(f"call {args.edit}")
        return # without asking for input

    if args.delete:
        try:
            if os.path.exists(filepath):
                os.remove(filepath)
                print(f"Successfully deleted '{filepath}'.")
            else:
                print(f"File '{filepath}' does not exist, so it cannot be deleted.")
        except OSError as e:
            print(f"Error deleting file '{filepath}': {e}")
        return # Exit after deleting

    file_exists = os.path.exists(filepath)
    initial_mode = 'w' # Default for new files or when clearing

    if args.clear:
        # If --clear is specified, always overwrite
        initial_mode = 'w'
    elif file_exists:
        # If file exists and --clear is NOT specified, default to append
        initial_mode = 'a'
    else: # File does not exist
        if args.new:
            # If --new is specified, create a new file (write mode)
            initial_mode = 'w'
        else:
            # If file doesn't exist and --new is NOT specified, raise an error
            print(f"Error: File '{filepath}' does not exist. Use -n or --new to create it.")
            return # Exit if file doesn't exist and --new is not given

    # Determine if we need to prompt for input (i.e., no text provided on command line)
    if not args.text:
        print(f"Entering interactive mode for '{filepath}'.")
        print("To finish, press Ctrl+D or enter an empty line.")
        first_line_written = False
        while True:
            try:
                # Check if stdin is a TTY before prompting to avoid issues in non-interactive environments
                if sys.stdin.isatty():
                    line = input("> ")
                else:
                    # If not a TTY (e.g., piped input), read line from stdin directly
                    line = sys.stdin.readline()
                    if not line: # EOF for non-TTY
                        break
            except EOFError:
                print("\nEOF received. Finishing input.")
                break # Exit on Ctrl+D

            if not line.strip(): # Check for empty line after stripping whitespace
                print("Empty line received. Finishing input.")
                break

            # Ensure each line ends with a newline character for proper file formatting
            if not line.endswith('\n'):
                line += '\n'

            # Use the determined initial_mode for the very first line, then always append
            current_mode = initial_mode if not first_line_written else 'a'
            write_to_file(filepath, line, current_mode)
            first_line_written = True

    else: # Text was provided on the command line
        text_to_write = " ".join(args.text)
        # Ensure the command-line text also ends with a newline for consistency
        if not text_to_write.endswith('\n'):
            text_to_write += '\n'
        write_to_file(filepath, text_to_write, initial_mode)


if __name__ == "__main__":
    main()

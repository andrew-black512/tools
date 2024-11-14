#!/usr/bin/python3

import argparse

def main():
  """Parses command-line arguments and performs tagging."""
  # Create an ArgumentParser object
  parser = argparse.ArgumentParser(description="Tag text with user-specified tag.")

  # Add argument for tag name
  parser.add_argument("tag", type=str, help="The tag to be used for wrapping text.")

  # Add optional argument for uppercasing (-u or --ucase)
  parser.add_argument("-u", "--ucase", action="store_true", default=False,
                      help="Convert the input text to uppercase before tagging.")

  # Parse arguments from the command line
  args = parser.parse_args()

  # Get user input text
  text = input("Enter text to be tagged: ")

  # Apply uppercasing if the flag is set
  if args.ucase:
    text = text.upper()

  # Generate the tagged output
  tagged_text = f"<{args.tag}>{text}</{args.tag}>"

  # Print the result
  print(tagged_text)

if __name__ == "__main__":
  main()
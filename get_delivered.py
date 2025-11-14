import mailbox
from collections import Counter
import sys

def count_delivered_to_emails(file_path):
    """
    Reads an mbox file, extracts the X-Delivered-To header from each message,
    and counts the occurrences of each email address.

    Args:
        file_path (str): The path to the mbox mail file.

    Returns:
        Counter: A Counter object containing the email addresses and their counts.
    """
    delivered_to_counts = Counter()
    
    try:
        # Open the mailbox file in read mode
        mbox = mailbox.mbox(file_path)
    except FileNotFoundError:
        print(f"Error: File not found at '{file_path}'")
        return delivered_to_counts
    except mailbox.FormatError:
        print(f"Error: The file '{file_path}' is not a valid mbox format.")
        return delivered_to_counts

    print(f"Processing mail file: {file_path}")
    
    # Iterate through each message in the mbox file
    for message in mbox:
        # Get the value of the 'X-Delivered-To' header
        delivered_to = message.get("X-Delivered-To")
        
        if delivered_to:
            # The header might sometimes contain extra info or be comma-separated,
            # but usually for this header, we just need the email address.
            # We strip whitespace for cleanliness.
            email_address = delivered_to.strip()
            
            # Increment the count for this email address
            delivered_to_counts[email_address] += 1
            
    return delivered_to_counts

def display_results(counts):
    """
    Displays the counted email addresses and their occurrences, sorted by count.
    """
    if not counts:
        print("\nNo 'X-Delivered-To' headers found or file was empty/invalid.")
        return

    print("\n--- X-Delivered-To Email Counts ---")
    
    # Sort the results by count in descending order
    sorted_counts = sorted(counts.items(), key=lambda item: item[1], reverse=True)
    
    for email, count in sorted_counts:
        print(f"**{email}**: {count}")
    
    print("-" * 35)

if __name__ == "__main__":
    # Check if a file path was provided as a command-line argument
    if len(sys.argv) < 2:
        print("Usage: python your_script_name.py <path_to_mail_file>")
        print("Example: python mail_counter.py my_archive.mbox")
    else:
        mail_file_path = sys.argv[1]
        
        # Get the counts
        email_counts = count_delivered_to_emails(mail_file_path)
        
        # Display the results
        display_results(email_counts)
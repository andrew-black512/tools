#!/usr/bin/env python3

import os
import re
import argparse
from datetime import datetime

# Configuration
DOWNLOADS_PATH = os.path.expanduser("~/Downloads")
LOG_FILE = "file_operations.log"

def log_action(message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG_FILE, "a") as f:
        f.write(f"[{timestamp}] {message}\n")

def process_files(instruction_file, dry_run=False):
    if not os.path.exists(instruction_file):
        print(f"Error: Instruction file '{instruction_file}' not found.")
        return

    status_prefix = "[DRY RUN] " if dry_run else ""
    if dry_run:
        print("--- DRY RUN MODE ACTIVE: No changes will be made ---")

    with open(instruction_file, 'r') as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if not line or line.startswith("#"): continue 

            parts = line.split()
            verb = parts[0].upper()
            print(f'v={verb}')

            for filename in os.listdir(DOWNLOADS_PATH):
                file_path = os.path.join(DOWNLOADS_PATH, filename)
                if not os.path.isfile(file_path): continue

                # DELETE OPERATIONS
                if verb in ["DEL", "DELP"]:
                    pattern = parts[1]
                    if re.search(pattern, filename):
                        action_msg = f"{verb}: {filename}"
                        
                        if verb == "DEL":
                            print(f"{status_prefix}Deleting: {filename}")
                            if not dry_run:
                                os.remove(file_path)
                                log_action(action_msg)
                        
                        elif verb == "DELP":
                            if dry_run:
                                print(f"{status_prefix}Would prompt to delete: {filename}")
                            else:
                                confirm = input(f"[DELP] Delete '{filename}'? (y/n): ").lower()
                                if confirm == 'y':
                                    os.remove(file_path)
                                    log_action(action_msg)

                # RENAME OPERATION
                elif verb == "REN":
                    if len(parts) < 3:
                        print(f"Line {line_num}: REN requires pattern AND replacement.")
                        break
                    
                    search_pattern, replacement = parts[1], parts[2]
                    #print (f's{search_pattern} {filename}')
                    if re.search(search_pattern, filename):
                        new_name = re.sub(search_pattern, replacement, filename)
                        action_msg = f"REN: {filename} -> {new_name}"
                        
                        print(f"{status_prefix}{action_msg}")
                        if not dry_run:
                            os.rename(file_path, os.path.join(DOWNLOADS_PATH, new_name))
                            log_action(action_msg)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Clean up Downloads directory.")
    parser.add_argument("file", help="Input file with instructions.")
    parser.add_argument("-n", "--dryrun", action="store_true", help="Preview mode.")
    
    args = parser.parse_args()
    print(args.file)
    process_files(args.file, dry_run=args.dryrun)

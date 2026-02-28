import os
import argparse
from datetime import datetime, timedelta

def format_date(timestamp):
    file_dt = datetime.fromtimestamp(timestamp)
    now = datetime.now()
    today = now.date()
    yesterday = today - timedelta(days=1)
    
    # Logic for Today/Yesterday
    if file_dt.date() == today or file_dt.date() == yesterday:
        return file_dt.strftime("%d-%b %H:%M")
    # Logic for < 1 year (365 days)
    elif now - file_dt < timedelta(days=365):
        return file_dt.strftime("%d-%b      ")
    # Logic for older than 1 year
    else:
        return file_dt.strftime("%d-%b %Y")

def list_items(path, sort_by_time):
    if not os.path.exists(path):
        print(f"pyls: {path}: No such file or directory")
        return

    # Determine if we are looking at a single file or a directory
    if os.path.isfile(path):
        items = [path]
    else:
        try:
            items = [os.path.join(path, f) for f in os.listdir(path) if not f.startswith('.')]
        except PermissionError:
            print(f"pyls: {path}: Permission denied")
            return

    data = []
    for item in items:
        try:
            stats = os.stat(item)
            data.append({
                'name': os.path.basename(item),
                'size': stats.st_size,
                'mtime': stats.st_mtime,
                'is_dir': os.path.isdir(item)
            })
        except OSError:
            continue

    # Sorting logic
    if sort_by_time:
	    data.sort(key=lambda x: x['mtime'])
    else:
        data.sort(key=lambda x: x['name'].lower())

    # Print Header-less table
    for f in data:
        date_str = format_date(f['mtime'])
        indicator = "/" if f['is_dir'] else " "
        # Format: Size(12 chars) | Dir Indicator | Date | Filename
        print(f"{f['size']:>12} {indicator} {date_str}  {f['name']}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("path", nargs="?", default=".")
    parser.add_argument("-t", action="store_true")
    args = parser.parse_args()
    
    list_items(args.path, args.t)

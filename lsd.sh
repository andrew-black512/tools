import os
import time
from datetime import datetime, timedelta

def format_date(timestamp):
    file_dt = datetime.fromtimestamp(timestamp)
    now = datetime.now()
    today = now.date()
    yesterday = today - timedelta(days=1)
    
    # Check for Today or Yesterday
    if file_dt.date() == today:
        return file_dt.strftime("%d-%b %H:%M")
    elif file_dt.date() == yesterday:
        return file_dt.strftime("%d-%b %H:%M")
    
    # Check if less than a year ago (365 days)
    elif now - file_dt < timedelta(days=365):
        return file_dt.strftime("%d-%b      ")
    
    # Older than a year
    else:
        return file_dt.strftime("%d-%b %Y")

def list_files():
    # Get files and sort them (optional, mimics ls)
    files = sorted([f for f in os.listdir('.') if not f.startswith('.')])
    
    for name in files:
        stats = os.stat(name)
        
        # Mimic ls -l columns: mode, nlink, user, group, size, date, name
        # Simplified here for clarity focusing on the date/size/name
        size = stats.st_size
        mtime = format_date(stats.st_mtime)
        
        print(f"{size:>10}  {mtime}  {name}")

if __name__ == "__main__":
    list_files()

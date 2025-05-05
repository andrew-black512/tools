import subprocess
import sys
import pyperclip
from urllib.parse import urlparse


def ping_host(host):
    """
    Pings a given host and prints the output.

    Args:
        host (str): The hostname or IP address  to ping.
    """
    param = '-n' if sys.platform == 'win32' else '-c'
    command = ['ping', param, '4', host]

    try:
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate(timeout=5)  # Wait for a maximum of 5 seconds

        if process.returncode == 0:
            print(stdout.decode())
        else:
            print(f"Error pinging {host}:")
            print(stderr.decode())

    except subprocess.TimeoutExpired:
        print(f"Pinging {host} timed out.")
    except FileNotFoundError:
        print("Error: 'ping' command not found. Make sure it's in your system's PATH.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        target = pyperclip.paste()
    else :
        target = sys.argv[1]

    # Try to parse as a URL
    parsed_url = urlparse(target)
    if parsed_url.netloc:
        hostname_to_ping = parsed_url.netloc
        print(f"Extracted hostname from URL: {hostname_to_ping}")
    else:
        hostname_to_ping = target

    print(f"Pinging {hostname_to_ping}...")
    ping_host(hostname_to_ping)

#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Prompt user to enter a list of usernames to keep
echo "Enter the usernames you want to keep (comma-separated):"
read -r keep_usernames_input

# Convert the input to an array
IFS=',' read -r -a keep_usernames <<< "$keep_usernames_input"

# Delete non-system user accounts
getent passwd | while IFS=: read -r username _ uid _ ; do
    # Check if the user is not root, not a system account, and not in the list of usernames to keep
    if [ "$username" != "root" ] && [ "$username" != "nobody" ] && [ "$uid" -ge 1000 ] && ! [[ " ${keep_usernames[@]} " =~ " $username " ]]; then
        # Delete the user
        userdel -r "$username" >/dev/null 2>&1
        echo "User '$username' deleted."
    fi
done

echo "User deletion process complete."

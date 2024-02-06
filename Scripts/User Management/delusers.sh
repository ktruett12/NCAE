#!/bin/bash

# Prompt user to enter a list of malicious usernames to delete
echo "Enter the usernames you want to delete (comma-separated):"
read -r malicious_usernames_input

# Convert the input to an array
IFS=',' read -r -a malicious_usernames <<< "$malicious_usernames_input"

# Delete malicious user accounts
for username in "${malicious_usernames[@]}"; do
    # Check if the user exists and is not root
    if id "$username" &>/dev/null && [ "$username" != "root" ]; then
        # Delete the user
        userdel -r "$username" >/dev/null 2>&1
        echo "User '$username' deleted."
    else
        echo "User '$username' does not exist or is root. Skipping deletion."
    fi
done

echo "User deletion process complete."

#!/bin/bash

# Prompt the user to enter the new password
read -sp "Enter the new password: " new_password
echo

# Iterate over all user accounts except root
for user in $(awk -F':' '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd); do
    # Change the password for each user
    echo -e "$new_password\n$new_password" | passwd "$user"
    if [ $? -eq 0 ]; then
        echo "Password changed successfully for user: $user"
    else
        echo "Failed to change password for user: $user"
    fi
done

echo "All user passwords have been changed."

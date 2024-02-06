#! /bin/bash

# Get a list of all users except system users and root
users=$(getent passwd | grep -vE '(nologin|false|sync|halt)' | cut -d: -f1)

# Iterate through each user and change their password
for user in $users; do
    # Change the user's password to "K!dst@bl3"
    echo -e "K!dst@bl3\nK!dst@bl3" | passwd $user

    # Output the changed password
    echo "Password changed for user: $user"
    echo "New password: K!dst@bl3"
done

echo "Password change process complete."

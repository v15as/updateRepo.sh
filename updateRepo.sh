#!/bin/bash

# Add this to your repository

echo -n "Branch to update: "
read branch

if git checkout -q $branch; then
    echo -n "Insert operation (push or pull): "
    read operation

    if [ "$operation" = "push" ]; then
        git add .
        echo -n "Insert message of commit: "
        read message
        git commit -m "$message"
        valido=1

    elif [ "$operation" = "pull" ]; then
        echo "pulling"
        valido=1
    else
        echo "Invalid or missing argument. Give a valid argument (push ou pull)"
        valido=0
    fi
    if [ $valido -eq 1 ]; then

        echo -n "Insert main branch: "
        read main_branch

        if git checkout -q $main_branch; then
            git checkout -q $branch
            if [ "$operation" = "push" ]; then
                git checkout $main_branch
                git merge $branch
                git push origin $main_branch
                git checkout $branch

            elif [ "$operation" = "pull" ]; then
                git checkout $main_branch
                git pull origin $main_branch
                git checkout $branch
                git merge $main_branch
            else
                echo "Failed to checkout branch. Probably missing."
            fi
        fi
    fi

else
    echo "Failed to checkout branch. Probably missing."
fi

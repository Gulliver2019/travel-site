#!/bin/bash

# Define log file
LOGFILE="/Users/graham.x.davidson/Documents/travel-site/cron.log"

# Navigate to the project directory
cd /Users/graham.x.davidson/Documents/travel-site || {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to navigate to project directory" >> "$LOGFILE"
    exit 1
}

# Get the current branch name
current_branch=$(git branch --show-current 2>>"$LOGFILE")

if [ -z "$current_branch" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to determine the current branch" >> "$LOGFILE"
    exit 1
fi

# Check if the current branch is 'main' and pull the latest changes if it is
if [ "$current_branch" == "main" ]; then
    git pull origin master >> "$LOGFILE" 2>&1 || {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to pull from origin main" >> "$LOGFILE"
        exit 1
    }
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully updated the main branch" >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Not on the main branch, no update performed" >> "$LOGFILE"
fi

#!/bin/bash

GIT_WORK_PATH=~/dev/projects/fullcast/data-intelligence.git

# Copy .env for all the packages and apps and paste them in their respective folders
for f in "$GIT_WORK_PATH"/branches/main/packages/*/.env "$GIT_WORK_PATH"/branches/main/apps/*/.env; do
  if [ -f "$f" ]; then
    echo "$f"
    # Uncomment below to actually copy .env files
    # cp "$f" /path/to/destination/
  fi
done

#!/bin/bash

# Check if a folder name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <FolderName>"
  exit 1
fi

# Original and lowercase folder names
ORIG_FOLDER="$1"
LOWER_FOLDER="$(echo "$ORIG_FOLDER" | tr '[:upper:]' '[:lower:]')"

# Rename the folder to lowercase if it's not already
if [ "$ORIG_FOLDER" != "$LOWER_FOLDER" ]; then
  if [ -d "$LOWER_FOLDER" ]; then
    echo "Target lowercase folder '$LOWER_FOLDER' already exists. Aborting."
    exit 1
  fi
  mv "$ORIG_FOLDER" "$LOWER_FOLDER"
fi

# Move files from "linux scripts" into the renamed folder
if [ ! -d "linux scripts" ]; then
  echo "Nearby folder 'linux scripts' not found. Aborting."
  exit 1
fi

mv "linux scripts"/* "$LOWER_FOLDER"/

# Run the master_script.sh
if [ -x "$LOWER_FOLDER/master_script.sh" ]; then
  "$LOWER_FOLDER/master_script.sh"
else
  echo "Script '$LOWER_FOLDER/master_script.sh' not found or not executable."
  exit 1
fi


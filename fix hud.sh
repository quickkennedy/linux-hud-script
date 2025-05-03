#!/bin/bash

# Check if a folder name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <FolderName>"
  exit 1
fi

# Original and lowercase folder names
ORIG_FOLDER="$1"
LOWER_FOLDER="$(echo "$ORIG_FOLDER" | tr '[:upper:]' '[:lower:]')"

mv "$ORIG_FOLDER" "$LOWER_FOLDER"

# Move files from "linux scripts" into the renamed folder
if [ ! -d "linux scripts" ]; then
  echo "Nearby folder 'linux scripts' not found. Aborting."
  exit 1
fi

mv "linux scripts"/* "$LOWER_FOLDER"/

cd $LOWER_FOLDER

./master_script.sh

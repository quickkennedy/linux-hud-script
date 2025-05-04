#!/bin/bash

# Get the current directory name only (not full path)
current_folder=$(basename "$PWD")

# Define the folder containing .cfg files
cfg_folder="./cfg"

# Safety check
if [ ! -d "$cfg_folder" ]; then
    echo ">> [Error] Folder '$cfg_folder' not found. Exiting."
    exit 1
fi

# Loop through all .cfg files in the cfg folder
find "$cfg_folder" -type f -name "*.cfg" | while read -r file; do
    echo ">> Parsing: $file"

    # Use sed to replace both path patterns
    sed -i \
        -e "s|\.\./\.\./resource/|../../custom/$current_folder/resource/|g" \
        -e "s|\.\./\.\./scripts/|../../custom/$current_folder/scripts/|g" \
        "$file"

    echo ">> Replaced $file with current dir '$current_folder'"
done

#loop through res files and fix their paths
find . -type f -name "*.res" | while read -r file; do
    echo "Patching: $file"
    # Rewrite in place, no backups, no looking back
    sed -i 's|\.\./cfg/|../../../cfg/|g' "$file"
done

echo ">> All done fixing logbase"


#!/bin/bash

#
# this fixes a given clientscheme, its not ran directly, only by "fix_all_clientschemes.sh"
#

# Define the file path from the first argument
file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found: $file"
  exit 1
fi

# Replace .ttf" with .otf"
sed -i 's/\.ttf"/\.otf"/g' "$file"

# Replace .otf" with -fixed.otf"
sed -i 's/\.otf"/-fixed.otf"/g' "$file"

echo "Replacements completed in $file"

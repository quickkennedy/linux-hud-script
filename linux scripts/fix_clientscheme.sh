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

# HACK --- FIX DEFAULT FONTS
sed -i \
    -e 's/ocra-fixed\.otf/ocra.ttf/Ig' \
    -e 's/tf2build-fixed\.otf/tf2build.ttf/Ig' \
    -e 's/tf2professor-fixed\.otf/tf2professor.ttf/Ig' \
    -e 's/tf2secondary-fixed\.otf/tf2secondary.ttf/Ig' \
    -e 's/tf2-fixed\.otf/tf2.ttf/Ig' \
    -e 's/tfd-fixed\.otf/tfd.ttf/Ig' \
    -e 's/tflogo-fixed\.otf/tflogo.ttf/Ig' \
    -e 's/tf-fixed\.otf/tf.ttf/Ig' \
    "$file"

echo "Replacements completed in $file"

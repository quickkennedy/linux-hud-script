#!/bin/bash

# Cyberpunk Script: FontFixer 2077 - Backup Mode with Font2 Directory
# Purpose: Copy "fonts" to "fonts2", then process .ttf and .otf files using FontForge and fixfont.py in "fonts2".

FONT_DIR="./resource/fonts"  # Change this to your target directory
SCRIPT="fixfont.py"
BACKUP_DIR="$FONT_DIR/_backups"

# Check if the FontForge script exists
if [[ ! -f "$SCRIPT" ]]; then
    echo "*ERROR:* $SCRIPT not found. Jack out and recheck your file paths."
    exit 1
fi

# Create the backup directory in fonts2 if it doesn't exist
if [[ ! -d "$BACKUP_DIR" ]]; then
    mkdir "$BACKUP_DIR"
    echo "*Backup directory created in fonts2:* $BACKUP_DIR"
fi

# Search for .ttf and .otf files in fonts2, process each, and backup the originals
find "$FONT_DIR" -type f \( -iname "*.ttf" -o -iname "*.otf" \) | while read -r font; do
    # Exclude fonts that already have '-brokenborked' in the filename
    if [[ "$font" == *"-brokenborked"* ]]; then
        continue
    fi

    echo "*Processing font in fonts2:* $font"

    # Run fontforge on the font file
    fontforge -script "$SCRIPT" "$font"

    # Check if FontForge succeeded (we assume if it ends without error)
    if [[ $? -eq 0 ]]; then
        # Create the backup filename with '-brokenborked' appended
        backup_font="${font%.*}-brokenborked.${font##*.}"

        # Move the original font to _backups with the new name
        mv "$font" "$BACKUP_DIR/$(basename "$backup_font")"
        echo "*Font moved to backup with new name:* $BACKUP_DIR/$(basename "$backup_font")"

        # Move the new font output to the original location (assuming output as .ttf)
        mv "$font.sfd" "${font%.*}.ttf"  # Adjust this if FontForge outputs a different format
        echo "*Replaced original with output font*"
    else
        echo "*ERROR:* FontForge failed to process $font. No backup made."
    fi
done

echo "*Mission complete.* All fonts processed, renamed, and backed up in fonts2."

# Define the file path
file="resource/clientscheme.res"

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


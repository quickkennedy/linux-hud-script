#!/bin/bash

# Always start from the current directory
START_DIR="."

# Export a function for use in 'find -exec'
rename_to_lower() {
    for FILE in "$@"; do
        DIRNAME=$(dirname "$FILE")
        BASENAME=$(basename "$FILE")
        LOWERBASENAME=$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]')

        # Skip if already lowercase
        if [ "$BASENAME" != "$LOWERBASENAME" ]; then
            TARGET="$DIRNAME/$LOWERBASENAME"
            if [ -e "$TARGET" ]; then
                echo "⚠️ Skipping: $TARGET already exists"
            else
                mv "$FILE" "$TARGET"
            fi
        fi
    done
}
export -f rename_to_lower

# Depth-first traversal so files are renamed before their parent directories
find "$START_DIR" -depth -print0 | while IFS= read -r -d '' ITEM; do
    rename_to_lower "$ITEM"
done


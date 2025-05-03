#!/bin/bash

# Start from the root file
START_FILE="resource/clientscheme.res"
FIX_SCRIPT="./fix_clientscheme.sh"
VISITED_FILE=".visited_clientschemes.tmp"

# Make sure we start clean
> "$VISITED_FILE"

# Use an associative array to avoid duplicate processing (bash 4+)
declare -A visited

function resolve_path() {
    local base_dir="$1"
    local rel_path="$2"
    local abs_path

    # Remove surrounding quotes if any
    rel_path="${rel_path%\"}"
    rel_path="${rel_path#\"}"

    # Resolve relative path
    abs_path=$(realpath --no-symlinks --quiet --canonicalize-missing "$base_dir/$rel_path")
    echo "$abs_path"
}

function process_file() {
    local file="$1"

    # Avoid reprocessing
    if [[ -n "${visited[$file]}" ]]; then return; fi
    visited["$file"]=1
    echo "$file" >> "$VISITED_FILE"

    # Only process existing files
    if [[ -f "$file" ]]; then
        echo "Running fix_clientscheme.sh on $file"
        "$FIX_SCRIPT" "$file"
    else
        return
    fi

    # Now extract #base references and follow them
    local base_dir
    base_dir=$(dirname "$file")

    while IFS= read -r line; do
        base_path=$(echo "$line" | sed -n 's/^#base\s\+"\(.*\)"/\1/p')
        [[ -n "$base_path" ]] || continue
        resolved=$(resolve_path "$base_dir" "$base_path")
        process_file "$resolved"
    done < <(grep -E '^#base\s+"[^"]+"' "$file")
}


# Start the recursive chaos
process_file "$(realpath "$START_FILE")"

# List of all processed client schemes
echo "Clientschemes processed:"
cat "$VISITED_FILE"

# Clean up
rm "$VISITED_FILE"


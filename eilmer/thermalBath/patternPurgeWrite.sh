#!/bin/bash

# === SETTINGS ===
keep_every=1000  # Keep every N-th file based on numeric suffix

# === PROTECTED FILES: Never delete these ===
protected_files=(
    "t0001"
    "t0010"
    "t0020"
    "t0030"
    "t0040"
    "t0050"
    "t0060"
    "t0070"
    "t0080"
    "t0090"
    "t0100"
    "t0200"
    "t0300"
    "t0400"
    "t0500"
    "t0600"
    "t0700"
    "t0800"
    "t0900"
    "t1000"
    "t10000"
    "t100000"
    "t1000000"
)

# Convert to string for fast matching
protected_pattern="|$(IFS="|"; echo "${protected_files[*]}")|"

echo "Cleaning directory: keeping every $keep_every-th file, except protected files."

deleted_any=false

for file in flow/t*; do
    [ -e "$file" ] || continue

    filename=$(basename "$file")

    # Skip protected files
    if [[ "$protected_pattern" == *"|$filename|"* ]]; then
        echo "Protected: $filename"
        continue
    fi

    # Extract numeric suffix (after 't')
    number="${filename#t}"
    if [[ "$number" =~ ^[0-9]+$ ]]; then
        if (( 10#$number % keep_every != 0 )); then
            echo "Deleting $file"
            rm -r "$file"
            deleted_any=true
        else
            echo "Keeping (every $keep_every): $filename"
        fi
    else
        echo "Skipping: $filename (invalid format)"
    fi
done

if [ "$deleted_any" = false ]; then
    echo "No files deleted. Exiting."
fi

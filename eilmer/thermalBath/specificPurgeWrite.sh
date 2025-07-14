#!/bin/bash

# List of filenames to keep (without path)
keep_files=(
    "t0001"
    "t0010"
    "t0100"
    "t1000"
    "t10000"
    "t100000"
    "t1000000"
)

# Convert array to a pattern to match against
keep_pattern=$(printf "|%s" "${keep_files[@]}")
keep_pattern="|${keep_pattern:1}|"

echo "Running cleanup loop. Will stop if nothing needs deletion."

while true; do
    deleted_any=false

    for file in flow/*; do
        [ -e "$file" ] || continue

        if [[ "$keep_pattern" != *"|$file|"* ]]; then
            echo "Deleting $file"
            rm -r "$file"
            deleted_any=true
        else
            echo "Keeping $file"
        fi
    done

    if [ "$deleted_any" = false ]; then
        echo "No more files to delete. Exiting."
        break
    fi
done

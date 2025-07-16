#!/bin/bash

# List of filenames to keep (without path)
keep_files=(
    "history.csv"
    "test_flow_00000.vtk"
    "test_flow_00010.vtk"
    "test_flow_00100.vtk"
    "test_flow_01000.vtk"
    "test_flow_10000.vtk"
    "test_flow_100000.vtk"
    "test_flow_1000000.vtk"
)

# Convert array to a pattern to match against
keep_pattern=$(printf "|%s" "${keep_files[@]}")
keep_pattern="|${keep_pattern:1}|"

echo "Running cleanup loop. Will stop if nothing needs deletion."

while true; do
    deleted_any=false

    for file in *.csv *.vtk; do
        [ -e "$file" ] || continue

        if [[ "$keep_pattern" != *"|$file|"* ]]; then
            echo "Deleting $file"
            rm "$file"
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

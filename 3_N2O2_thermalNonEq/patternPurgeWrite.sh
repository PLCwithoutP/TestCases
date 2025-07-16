#!/bin/bash

# === SETTINGS ===
keep_every=1000  # Keep every N-th file based on numeric suffix
file_exts=("csv" "vtk")

# === PROTECTED FILES: Never delete these ===
protected_files=(
    "history.csv"
    "test_flow_00000.vtk"
    "test_flow_00010.vtk"
    "test_flow_00020.vtk"
    "test_flow_00030.vtk"
    "test_flow_00040.vtk"
    "test_flow_00050.vtk"
    "test_flow_00060.vtk"
    "test_flow_00070.vtk"
    "test_flow_00080.vtk"
    "test_flow_00090.vtk"
    "test_flow_00100.vtk"
    "test_flow_00200.vtk"
    "test_flow_00300.vtk"
    "test_flow_00400.vtk"
    "test_flow_00500.vtk"
    "test_flow_00600.vtk"
    "test_flow_00700.vtk"
    "test_flow_00800.vtk"
    "test_flow_00900.vtk"
    "test_flow_01000.vtk"
    "test_flow_10000.vtk"
    "test_flow_100000.vtk"
    "test_flow_1000000.vtk"
)

# === Build pattern from protected file list ===
protected_pattern=$(printf "|%s" "${protected_files[@]}")
protected_pattern="|${protected_pattern:1}|"

echo "Cleaning directory: keeping every $keep_every-th file, except protected files."

deleted_any=false

for ext in "${file_exts[@]}"; do
    for file in *.$ext; do
        [ -e "$file" ] || continue

        # Skip if file is in protected list
        if [[ "$protected_pattern" == *"|$file|"* ]]; then
            echo "Protected: $file"
            continue
        fi

        # Extract numeric suffix
        filename_no_ext="${file%.*}"
        number="${filename_no_ext##*_}"

        if [[ "$number" =~ ^[0-9]+$ ]]; then
            # Force decimal interpretation (to avoid octal error)
            if (( 10#$number % keep_every != 0 )); then
                echo "Deleting $file"
                rm "$file"
                deleted_any=true
            else
                echo "Keeping (pattern match): $file"
            fi
        else
            echo "Skipping (no valid numeric suffix): $file"
        fi
    done
done

if [ "$deleted_any" = false ]; then
    echo "No files deleted. Exiting."
fi


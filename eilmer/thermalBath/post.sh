#!/bin/bash

echo "------------------------------------------------------Post-processing is starting.------------------------------------------------------"

time_file="time_post.txt"
log_file="log.eilmer4post_thermalBath"

# Clear time and log files
> "$time_file"
> "$log_file"

# Find existing time directories like tXXXX, extract indices, and sort them
for dir in flow/t[0-9]*; do
    if [ -d "$dir" ]; then
        tindx="${dir#flow/t}"  # remove the 't' prefix
        echo "Post-processing time index: $tindx"

        /usr/bin/time -p -o temp_time.txt \
            e4shared --post --job=thermalBath.lua --vtk-xml --tindx-plot="$tindx" >> "$log_file" 2>&1

        echo "Time index $tindx timing:" >> "$time_file"
        cat temp_time.txt >> "$time_file"
        echo "---------------------------" >> "$time_file"
    fi
done

rm -f temp_time.txt

echo "-------------------------- Post-process Timing Summary ------------------------"
cat "$time_file"
echo "--------------------------------------------------------------------------------"

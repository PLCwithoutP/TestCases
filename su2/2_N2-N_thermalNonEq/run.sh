#!/bin/bash

./clean.sh

echo "-------------------------- Starting SU2 Simulation --------------------------"

log_file="log.su2_nemo_ns_nativeLib"
time_file="time_su2_nativeLib.txt"
config_file="air5_native.cfg"
n_processors=2
#log_file="log.su2_nemo_ns_mpp"
#time_file="time_su2_mpp.txt"
#config_file="air5_mutationpp.cfg"
# Create log and start tail in background
touch "$log_file"
tail -f "$log_file" &
TAIL_PID=$!

# Run SU2 with timing
/usr/bin/time -p -o "$time_file" \
    mpirun -np $n_processors SU2_CFD "$config_file" > "$log_file" 2>&1

# Kill tail
kill $TAIL_PID

# Display timing info
echo "------------------------------ SU2 Timing (s) ------------------------------"
cat "$time_file"
echo "----------------------------------------------------------------------------"

#!/bin/bash

echo "------------------------------------------------------Simulation is starting.------------------------------------------------------"

# Measure time for RUN
/usr/bin/time -p -o time_run.txt \
    e4shared --run --job=thermalBath.lua --verbosity=1 --max-cpus=6 > log.eilmer4run_thermalBath

echo "----------------------------- Run Timing (s) -----------------------------"
cat time_run.txt
echo "-------------------------------------------------------------------------"

echo "------------------------------------------------------Simulation is completed.------------------------------------------------------"

#!/bin/bash

echo "Cleaning case setup..."
echo "CSV files: "
ls *csv
rm *csv
echo "OutputCSVs files: "
ls outputCSVs/*csv
rm outputCSVs/*csv
echo "VTK files: "
ls *vtk
rm *vtk
echo "Log files: "
ls log*
rm log*
echo "Cleaning is completed!"

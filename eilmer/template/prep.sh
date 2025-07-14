#!/bin/bash

echo "------------------------------------------------------Preparing the gas model, reactions, energy exchange!------------------------------------------------------"
# Prepare the solver
prep-gas air-5sp-gas-model.lua air-5sp-2T.gas
lmr prep-reactions -g air-5sp-2T.gas -i GuptaEtAl-air-reactions-2T.lua -o air-5sp-6r-2T.chem
lmr prep-energy-exchange -g air-5sp-2T.gas -r air-5sp-6r-2T.chem -i air-energy-exchange.lua -o air-VT.exch

echo "------------------------------------------------------Preparing the grid!------------------------------------------------------"
# Prepare the grid
e4shared --prep --job=thermalBath.lua

echo "------------------------------------------------------Preparation stage is completed.------------------------------------------------------"

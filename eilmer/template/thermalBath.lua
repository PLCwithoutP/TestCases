print("*********************Flow Preparation is Started!*********************")
print("Goal: Run adiabatic heat bath case for Eilmer in order to compare with other solvers.")
config.title = "Thermal Bath from SU2"
config.dimensions = 3
config.axisymmetric = false
config.solver_mode = "transient"
config.gas_model_file = "air-5sp-2T.gas"
print("*********************Importing SU2 Grid is Started!*********************")
-- Import SU2 Grid
local ug = UnstructuredGrid:new{
  filename="thermalBath_1cell.su2", 
  fmt="su2text", 
  scale=1.0
}

RegisteredGrid = {}
RegisteredGrid[1] = {
  grid=ug, 
  tag="main", 
  fsTag="ic", 
  bcTags={"outer"}
}

nsp, nmodes = setGasModel("air-5sp-2T.gas")
print("5-species, 2T air model: nsp= ", nsp, " nmodes= ", nmodes)

-- Define the initial flow state dictionary
flowStates = {
  ic = FlowState:new{
    p=6383.475,
    T = 10000,
    T_modes={10000},
    massf={N2=0.79, O2=0.21} -- Pa, degrees K
  }
}
flowDict = {
    ic=ic
}
-- Define bc dictionary matching SU2 tags
bcDict = {
  outer = WallBC_WithSlip:new{}  -- default, but made explicit
}

-- Build flow blocks
--makeFluidBlocks(bcDict, flowStates)
block = FluidBlock:new{
    grid = ug,
    initialState = flowStates.ic,
    bcList = bcList
}
print("*********************Importing Process is Completed!*********************")

-- Simulation parameters
config.gasdynamic_update_scheme = "predictor-corrector"
config.fixed_time_step = true
config.dt_init = 1e-9 -- seconds
config.dt_max = 1e-9
config.max_time = 1e-3 -- seconds
config.max_step = 10000000
config.dt_plot = 1e-9
config.extrema_clipping = false
config.reacting = true
config.reactions_file = 'air-5sp-6r-2T.chem'
config.energy_exchange_file = 'air-VT.exch'
print("*********************Flow Preparation Process is Completed!*********************")
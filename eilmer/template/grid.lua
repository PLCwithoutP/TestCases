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
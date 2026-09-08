function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Give an order to this unit to load or unload units in an given area defined by its center and radius.",
		parameterDefs = {
			{ 
				name = "unload",
				variableType = "expression",
				componentType = "checkBox",
				defaultValue = "",
			},			
			{ 
				name = "center",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "radius",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

--[[
Node name: Give Load/Unload Order
Parameters
	unload: if false gives load order, if true gives unload order
	center: center of the area where units will be loaded/unloaded
	radius: radius of the area where units will be loaded/unloaded
Definition of SUCCESS: 
	The given command has finished executing.
Definition of FAIL: 
	None.
Definition of RUNNING: 
	The given command is still executing.
Init (only first time): 
	Give the load/unload order.
Once running (always): 
	Check if the command has finished executing (the success condition).
]]--

function Run(self, units, parameter)
	if not self.initialized then
		self.initialized = true
		if parameter.unload then
			Spring.GiveOrderToUnit(units[1], CMD.UNLOAD_UNITS, {parameter.center["x"], parameter.center["y"], parameter.center["z"], parameter.radius}, {})
		else
			Spring.GiveOrderToUnit(units[1], CMD.LOAD_UNITS, {parameter.center["x"], parameter.center["y"], parameter.center["z"], parameter.radius}, {})
		end
		return RUNNING
	end

	if Spring.GetUnitCommands(units[1], 0) == 0 then
		return SUCCESS
	end

    return RUNNING
end

function Reset(self)
	self.initialized = false
end
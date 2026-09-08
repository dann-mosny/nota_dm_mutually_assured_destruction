function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Find a point on each hill and send one unit to each one to capture them.",
		parameterDefs = {
			{ 
				name = "hillHeight",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		}
	}
end

--[[
Node name: Capture Hills
Parameters
	hillHeight: the minimum height for a point to be considered a hill
Definition of SUCCESS: 
	All units have finished executing their commands.
Definition of FAIL: 
	None.
Definition of RUNNING: 
	Some unit is still executing its command.
Init (only first time): 
	Find positions of hills and give orders to units to move to them (one unit per hill from right to left).
Once running (always): 
	Check if all units have finished executing their commands (the success condition).
]]--

local function manhattanDistance(a, b)
    return math.abs(a["x"] - b["x"]) + math.abs(a["z"] - b["z"])
end

local function alreadyFoundHill(point, hills)
    for i = 1, #hills do
        if manhattanDistance(point, hills[i]) < 500 then
            return true
        end
    end
    return false
end

local function findHills(hillHeight)
    local hills = {}
    local mapSizeX, mapSizeZ = Game.mapSizeX, Game.mapSizeZ
    for x = 0, mapSizeX, 100 do
        for z = 0, mapSizeZ, 100 do
            local height = Spring.GetGroundHeight(x, z)
            if height >= hillHeight then
                local point = Vec3(x, height, z)
                if not alreadyFoundHill(point, hills) then
                    table.insert(hills, point)
                end
            end
        end
    end
    return hills
end

function Run(self, units, parameter)
    if not self.initialized then
        self.initialized = true
        local hills = findHills(parameter.hillHeight)
        for i = 1, math.min(#hills, #units) do
            Spring.GiveOrderToUnit(units[i], CMD.MOVE, {hills[#hills - i + 1]["x"], hills[#hills - i + 1]["y"], hills[#hills - i + 1]["z"]}, {})
        end
        return RUNNING
    end

    for i = 1, #units do
        if Spring.GetUnitCommands(units[i], 0) ~= 0 then
            return RUNNING
        end
    end

    return SUCCESS
end

function Reset(self)
	self.initialized = false
end
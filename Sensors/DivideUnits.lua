local sensorInfo = {
	name = "DivideUnits",
	desc = "TODO",
	author = "Dann Mosny",
	date = "2026-09-10",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


return function()

	local allUnits  = Spring.GetTeamUnits(Spring.GetLocalTeamID())
	
	for i=1, #allUnits do
        if global.assignedUnits[allUnits[i]] == nil then
            global.assignedUnits[allUnits[i]] = true

            local unitDefId = Spring.GetUnitDefID(allUnits[i])
            if unitDefId == UnitDefNames['armfark'].id then
                global.units.farks[#global.units.farks + 1] = allUnits[i]
            elseif unitDefId == UnitDefNames['armmart'].id then
                global.units.lugers[#global.units.lugers + 1] = allUnits[i]
            elseif unitDefId == UnitDefNames['armmav'].id then
                global.units.mavericks[#global.units.mavericks + 1] = allUnits[i]
            elseif unitDefId == UnitDefNames['armseer'].id then
                global.units.seers[#global.units.seers + 1] = allUnits[i]
            elseif unitDefId == UnitDefNames['armspy'].id then
                global.units.spies[#global.units.spies + 1] = allUnits[i]
            end		
	    end
    end
end
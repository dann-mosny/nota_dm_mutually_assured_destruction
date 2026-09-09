local sensorInfo = {
	name = "GetLugers",
	desc = "TODO",
	author = "Dann Mosny",
	date = "2026-09-09",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


return function(array, dict)

	array = {}
	local allUnits  = Spring.GetTeamUnits(Spring.GetLocalTeamID())
	
	for i=1, #allUnits 
	do
		if Spring.GetUnitDefID(allUnits[i]) == UnitDefNames['armmart'].id and dict[allUnits[i]] == nil
		then 
			array[#array + 1] = allUnits[i]
			dict[allUnits[i]] = true
		end
		
	end
	
	return array

end
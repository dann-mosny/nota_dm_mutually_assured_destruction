local sensorInfo = {
	name = "WindLineFormation",
	desc = "Return position of units in a line formation perpendicular to the wind direction.",
	author = "Dann Mosny",
	date = "2026-04-27",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function()
    local positions = { Vec3(0, 0, 0) }
    local OFFSET = 50
    local POSITIONS_ON_ONE_SIDE = 100

    local dirX, _, dirZ = Spring.GetWind()
    local len = math.sqrt(dirX^2 + dirZ^2)
    if len == 0 then dirX, dirZ = 1, 0; len = 1 end

    -- perpendicular to the wind direction
    local perpX = -dirZ / len
    local perpZ = dirX / len

    for i = 1, POSITIONS_ON_ONE_SIDE do
        table.insert(positions, Vec3(i * OFFSET * perpX, 0, i * OFFSET * perpZ))
        table.insert(positions, Vec3(i * -OFFSET * perpX, 0, i * -OFFSET * perpZ))
    end

    return positions
end
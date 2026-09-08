-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Triggers manual mission end. Only missions which are designed to listed to this type of node are ended.",
		parameterDefs = {}
	}
end

function Run(self, units, parameter)
    message.SendRules({
        subject = "manualMissionEnd",
        data = {},
    })
	
	return SUCCESS
end


function Reset(self)
	return self
end
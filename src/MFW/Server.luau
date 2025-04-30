local Server = {}

function SpawnService(service: ModuleScript)
	local mod = require(service)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(service.Name)
	end)
end

function Server.Start(services: { ModuleScript })
	for i, service in ipairs(services) do
		SpawnService(service)
	end
end

return Server

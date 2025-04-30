local Client = {}

function SpawnController(controller: ModuleScript)
	local mod = require(controller)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(controller.Name)
	end)
end

function Client.Start(controllers: { ModuleScript })
	for i, controller in ipairs(controllers) do
		--Spawns controller:Start()
		SpawnController(controller)
	end
end

return Client

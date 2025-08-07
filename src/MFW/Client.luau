local Comm = require(script.Parent.Comm)
--local MFW = require(script.Parent)

local Client = {}

function SpawnController(controller: ModuleScript)
	local mod = require(controller)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(controller.Name)
	end)
end

local function GetServiceRegister(Service: {})
	--[[if Service then
		--
	end--]]
end

function Client.Start(controllers: { ModuleScript })
	for i, controller in ipairs(controllers) do
		--Spawns controller:Start()
		SpawnController(controller)
	end

	--local GetService: RemoteEvent = Comm:GetSignal("GetService")

	--GetService.OnServerEvent:Connect()
end

return {}

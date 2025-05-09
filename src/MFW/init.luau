--Services
local RunService = game:GetService("RunService")

--Variables
local McFrameWork = {}
local Controllers = {}
local Services = {}
local Signals = {}
local isServer = RunService:IsServer()

--Modules
local Comm = require(script:WaitForChild("Comm"))
local Client = require(script:WaitForChild("Client"))
local Server = require(script:WaitForChild("Server"))

--Typing

type Service = {
	Name: string,
	Client: {},
}

type Controller = {
	Name: string,
}

local MFW = {}

function MFW:StartClient(controllers: { ModuleScript })
	for i, controller in ipairs(controllers) do
		--Spawns controller:Start()
		MFW:SpawnStart(controller)
	end
end

function MFW:StartServer(services: { ModuleScript })
	for i, service in ipairs(services) do
		--Spawns service:Start()
		if service:IsA("ModuleScript") then
			MFW:SpawnStart(service)
		end
	end
end

--remote to pass to client to get service singals and client funcitons

function MFW:CreateSignal(name: string)
	--comm util
	local signal = Comm.CreateSignal(name)
	print(signal)
	return signal
	--Signals[name] = signal
end

function MFW:SpawnStart(module: ModuleScript)
	print(module)
	local mod = require(module)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(module.Name)
	end)
end

function MFW:GetService(ServiceName: string)
	--return table of signals and client-funtions
end

return MFW

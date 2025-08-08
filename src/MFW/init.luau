--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")


--Variables
local McFrameWork = {}
local Controllers = {}
local Services = {}
local isServer = RunService:IsServer()

--Modules
local Comm = require(script:WaitForChild("Comm"))
local Client = require(script:WaitForChild("Client"))
local Server = require(script:WaitForChild("Server"))
local Promise = require(ReplicatedStorage:WaitForChild("Promise"))

--Typing

type Service = {
	Name: string,
	Client: {},
}

type Controller = {
	Name: string,
}

local MFW = {}

function MFW:Init(modules: { ModuleScript })
	Comm:Init(modules)


	--TODO: Check if it has ?
	for i, mod in ipairs(modules) do
		if isServer then
			Services[mod.Name] = require(mod)
		else
			Controllers[mod.Name] = require(mod)
		end
		self:SpawnStart(mod)
	end

	local function waitForSignal()
		return Promise.new(function(resolve, reject, onCancel)
			task.wait(1)
			local signal = Comm:GetSignal("GetService")
			print(typeof(signal))
			if signal then
				print("Signal Found")
				resolve(signal)
			else
				reject("not found")
			end
		end)
	end

	Promise.retry(waitForSignal, 50)

	--[[
	GetService.OnServerEvent:Connect(function(player, ServiceName)
		local service = self:GetService(ServiceName)

		GetService:FireClient(player, service)
	end)

	print(Services)
	print(Controllers)--]]
end

function MFW:Start(modules: { ModuleScript })
	MFW:Init(modules)
end

function MFW:CreateSignal(name: string, signal_group: string)
	return Comm:CreateSignal(name, signal_group)
end

--[[
	TODO:
	Use external server and client start
	spawn client for when players join 
	create folders for all services in comm 

]]
--

function MFW:SpawnStart(module: ModuleScript)
	local mod = require(module)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(module.Name)
	end)
end

function MFW:GetService(ServiceName: string)
	--return table of signals and client-funtions

	--case:1 Server
	if isServer then
		if Services[ServiceName] then
			return Services[ServiceName]

		--case:2 Client
		else
			local GetService: RemoteEvent = Comm:GetSignal("GetService")
			GetService:FireServer(Players.LocalPlayer, ServiceName)

		end
	end

	return false
end

return MFW

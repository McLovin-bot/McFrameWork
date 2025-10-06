local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage:WaitForChild("Promise"))
local Comm = require(script.Comm)
local MFW = {}

local Services = {}
local Controllers = {}

function MFW:Start()
	MFW:Init()
end

function MFW:Init(modules: { ModuleScript })
	--Init communication module
	Comm:Init():await()
	print("Done")
	--Process services and controllers
	self:ProcessModules(modules)
	--Client Communication
	--GetService init
end

function SpawnModule(service: ModuleScript)
	local mod = require(service)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(service.Name)
	end)
end

function MFW:ProcessModules(modules: { ModuleScript })
	for i, mod in ipairs(modules) do
		
			
		if string.match(mod.Name, "Service") then
			Services[mod.Name] = require(mod)
		elseif string.match(mod.Name, "Controller") then
			Controllers[mod.Name] = require(mod)
		end
		--self:SpawnStart(mod)
		SpawnModule(mod)
	end
	print(Services)
	print(Controllers)
end

function MFW:GetService(service_name: string)
	--client vs server

	--client
	--fire getservice signal and wait for signal then
	return Promise.new(function(resolve, reject)

		local service = 

		resolve(Services)
	end)
end

function MFW:CreateSignal() end

return MFW

--[[
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

	--
	for i, mod in ipairs(modules) do
		if isServer then
			Services[mod.Name] = require(mod)
		else
			Controllers[mod.Name] = require(mod)
		end
		self:SpawnStart(mod)
	end

	local GetService: RemoteEvent = Comm:GetSignal("GetService")

	GetService.OnServerEvent:Connect(function(player, service)
		print(service)
	end)
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

function MFW:Start(modules: { ModuleScript })
	MFW:Init(modules)
end

function MFW:CreateSignal(name: string, signal_group: string)
	return Comm:CreateSignal(name, signal_group)
end

	TODO:
	Use external server and client start
	spawn client for when players join 
	create folders for all services in comm 


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

			--ask for service
			GetService:FireServer(Players.LocalPlayer, Services[ServiceName])

			--wait for service

			Promise.retry(waitForSignal, 50):andThen(function(Service)
				Services[Service.Name] = Service
			end)

			print(Services)

			if Services[ServiceName] then
				return Services[ServiceName]
			end
		end
	end

	return false
end

return MFW


]]
--

--[[local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage:WaitForChild("Promise"))
local Comm = require(script.Comm)

local MFW = {}

local Services = {}
local Controllers = {}

function MFW:Start()
	MFW:Init()
end

function MFW:Init(modules: { ModuleScript })
	print(modules)
	--Init communication module
	Comm:Init()
	--rocess services and controllers
	self:ProcessModules(modules)
	--Client Communication
	--GetService init
	print(Services)
	print(Controllers)
end

function MFW:ProcessModules(modules: { ModuleScript })
	for i, mod in ipairs(modules) do
		if RunService:IsServer() then
			Services[mod.Name] = require(mod)
		else
			Controllers[mod.Name] = require(mod)
		end
		--self:SpawnStart(mod)
	end
end

function MFW:ServerSync() end

function MFW:ClientSync() end

function MFW:Sync()
	--[[
		
	
	SYNC:onserver
	SYNC:onclient




	if RunService:IsServer() then
		local ClientServices = {}
		for i, service in ipairs(Services) do
			if service.Client then
				table.insert(ClientServices, service.Client)
			end
		end
		return ClientServices
	else
	end
end

function MFW:GetService(serviceName: string) end

function MFW:CreateSignal() end


return MFW
--]]

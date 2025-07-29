--Services
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

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

function MFW:Init(modules: { ModuleScript })
	print("MFW INIT")

	Comm:Init(modules)

	--TODO: Check if it has ?
	for i, mod in ipairs(modules) do
		self:SpawnStart(mod)
	end
end

function MFW:Start(modules: { ModuleScript })
	MFW:Init(modules)

	for i, module in ipairs(modules) do
		self:SpawnStart(module)
	end
end

function MFW:CreateSignal(name: string, signal_group: string)
	Comm:CreateSignal(name, signal_group)
end

--[[
	TODO:
	Use external server and client start
	spawn client for when players join 
	create folders for all services in comm 

]]
--
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

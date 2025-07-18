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

function MFW:Init()
	print("MFW INIT")
end

local function RegisterServices() end

function MFW:CreateSignal(name: string)
	--return remote
	-- init signals
	print(self)
	Comm.CreateSignal(name)
end

function CreateFolder(name: string, parent)
	local Folder = Instance.new("Folder")
	Folder.Parent = parent
	Folder.Name = name
	return Folder
end

--[[
	TODO:
	Use external server and client start
	spawn client for when players join 
	create folders for all services in comm 

]]
--

function MFW:StartClient(controllers: { ModuleScript })
	MFW:Init()
	Comm:Init(controllers)
end

function MFW:StartServer(services: { ModuleScript })
	print(services)
	MFW:Init()
	Comm:Init(services)
end

--remote to pass to client to get service singals and client funcitons

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

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

return MFW

--[[
local table1 = setmetatable(test_table, metatable)

print(table1.dog)

local function Init()
	--initilize client folder
	local ControllersFolder = Instance.new("Folder")
	ControllersFolder.Parent = script
	ControllersFolder.Name = "MFW_Controllers"

	--Controller Start
	for i, mod in pairs(Controllers) do
		print(i, mod)
		task.spawn(function()
			mod:Start()
			debug.setmemorycategory(i)
		end)
	end

	--Services Start
	for i, mod in pairs(Services) do
		task.spawn(function()
			mod:Start()
			debug.setmemorycategory(i)
		end)
	end
end

function LoadSignals(Service: string, Signals: Folder)
	for i, signal in ipairs(Signals) do
		Signals[signal] = CreateSignal(signal)
	end
end

function CreateSignal(SignalName: string)
	local signal = Instance.new("RemoteEvent")
	signal.Name = SignalName
	return signal
end

function LoadModules(children: {})
	--iterate modules
	for index, module: ModuleScript in ipairs(children) do
		--make sure we have a module scipt
		if module:IsA("ModuleScript") then
			--Controller case
			if string.match(module.Name, "Controller$") then
				local controller = require(module)
				Controllers[module.Name] = controller

			--Service case
			elseif string.match(module.Name, "Service$") and isServer then
				local mod = require(module)
				local Service = Instance.new("Folder")
				Service.Parent = script
				Service.Name = mod.Name
			
				Services[module.Name] = mod
				if mod.Signals then
					for i, v in pairs(mod.Signals) do
						table.insert(Signals, i)
					end
				end
			end
		end
	end
end

function McFrameWork.StartClient(modules)
	LoadModules(modules)
	Init()
	print(Controllers)
end

function McFrameWork.StartServer(modules)
	LoadModules(modules)
	Init()
	print(Signals)
end

function McFrameWork.GetService(service: string)
	print(service)
	if isServer then
		if Services[service] then
			return Services[service]
		end
	end
end

function McFrameWork.GetController(controller: string)
	if Controllers[controller] then
		return Controllers[controller]
	end
end

return McFrameWork--]]

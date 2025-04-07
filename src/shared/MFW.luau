local RunService = game:GetService("RunService")
local McFrameWork = {}

local Services = {}

local Controllers = {}

local Signals = {}

local isServer = RunService:IsServer()

local isClient = RunService:IsClient()

local function Init()
	--initilize client folder
	print(isClient, isServer)
	if isClient then
		print("yo")
		local ControllersFolder = Instance.new("Folder")
		ControllersFolder.Parent = script
		ControllersFolder.Name = "controllers"
	end

	if isClient then
		for i, mod in pairs(Controllers) do
			task.spawn(function()
				mod:Start()
				debug.setmemorycategory(i)
			end)
		end
	else
		for i, mod in pairs(Services) do
			task.spawn(function()
				mod:Start()
				debug.setmemorycategory(i)
			end)
		end
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
				--[[if script.Services == nil then
					local Services = Instance.new("Folder")
					Services.Parent = script
					Services.Name = "Services"
				end--]]
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

return McFrameWork

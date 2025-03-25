local RunService = game:GetService("RunService")
local McFrameWork = {}

local Services = {}

local Controllers = {}

local Signals = {}

local function SpawnStart()
	if RunService:IsClient() then
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
	for index, module: ModuleScript in ipairs(children) do
		if module:IsA("ModuleScript") then
			if string.match(module.Name, "Controller$") then
				local mod = require(module)
				Controllers[module.Name] = mod
				--RegisterModuleFunctions(require(module), module)
			elseif string.match(module.Name, "Service$") and RunService:IsServer() then
				local mod = require(module)
				print(mod)
				local Service = Instance.new("Folder")
				Service.Parent = script
				Service.Name = mod.Name
				--[[if script.Services == nil then
					local Services = Instance.new("Folder")
					Services.Parent = script
					Services.Name = "Services"
				end--]]
				print(mod)
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
	SpawnStart()
	print(Controllers)
end

function McFrameWork.StartServer(modules)
	LoadModules(modules)
	SpawnStart()
	print(Signals)
end

function McFrameWork.GetService(service: string)
	print(service)
	if RunService:IsServer() then
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

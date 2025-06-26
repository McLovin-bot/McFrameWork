local Comm = {}
local CoreSignals = {
	"GetService",
}

--create a remote event
--put it in the signals folder
--

local function CreateCoreSignals()
	local CoreFolder = Instance.new("Folder")
	CoreFolder.Name = "Core"
	CoreFolder.Parent = script

	for i, signal in ipairs(CoreSignals) do
		local remote = Instance.new("RemoteEvent")
		remote.Name = signal
		remote.Parent = CoreFolder
	end
end

local function SpawnStart(module: ModuleScript)
	local mod = require(module)
	task.spawn(function()
		mod:Start()
		debug.setmemorycategory(module.Name)
	end)
end

local function ServiceInit(services: { ModuleScript })
	for i, service in ipairs(services) do
		if service:IsA("ModuleScript") then
			--setup signal folder
			CreateFolder(service.Name, script)
			SpawnStart(service)
		end
	end
end

local function ClientInit(controllers: { ModuleScript })
	for i, controller in ipairs(controllers) do
		if controller:IsA("ModuleScript") then
			SpawnStart(controller)
		end
	end
end

function CreateFolder(name: string, parent)
	local Folder = Instance.new("Folder")
	Folder.Parent = parent
	Folder.Name = name
	return Folder
end

function Comm.Init(services: { ModuleScript }?)
	print(services)
	--[[
	if not script:FindFirstChild("Core") then
		CreateCoreSignals()
	end

	if services then
		ServiceInit(services)
	end
	--[[for i, service in ipairs() do
	end--]]
end

function Comm.CreateSignal(name: string)
	local remote = Instance.new("RemoteEvent")
	remote.Name = name
	return remote
end

--look in signal folder and return remote instance
function Comm.GetSignal(name: string)
	--return Signals:FindFirstChild(name)
	return 1
end

return Comm

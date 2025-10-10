local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Promise = require(ReplicatedStorage:WaitForChild("Promise"))

local Comm = {
	CoreSignals = {
		"GetService",
		"Sync",
	},
	RegisteredSignals = {},
}

local function SignalInit(self)
	if RunService:IsServer() then
		return Promise.new(function(resolve, reject)
			for i, signal in ipairs(self.CoreSignals) do
				self:CreateSignal(signal, "Core")
			end
			resolve(true)
		end)
	end
end

--turn into promise
function Comm:Init()
	return Promise.new(function(resolve, reject)
		SignalInit(self):await()
		resolve(true)
	end)
end

function GetServiceClient() end

function GetServiceServer() end

function Comm:CreateFolder(name: string)
	local folder = Instance.new("Folder")
	folder.Name = name
	return folder
end

function Comm:ConnectSignal(signal: RemoteEvent, signal_group: string)
	self.RegisteredSignals[signal_group][signal.Name] = signal

	if script[signal_group]:FindFirstChild(signal.Name) then
		return false
	end

	signal.Parent = script:FindFirstChild(signal_group)

	if signal.Parent and self.RegisteredSignals[signal.Name] then
		return true
	else
		return false
	end
end

function Comm:RegisterSignal(signal: RemoteEvent, signal_group: string)
	local RegisteredSignals = self.RegisteredSignals

	if RegisteredSignals[signal_group] then
		--duplicate name check
		if RegisteredSignals[signal_group][signal.Name] then
			error("[MFW-SIGNAL-ERROR] -- duplicate signal name detected in signal group " .. signal_group)
			return
		end

		self:ConnectSignal(signal, signal_group)
	else
		--init signal group index
		self:CreateSignalGroup(signal_group)

		self:ConnectSignal(signal, signal_group)
	end

	--self.RegisteredSignals[signal_group] = {}
	--table.insert(self.RegisteredSignals, signal)
end

function Comm:CreateSignalGroup(signal_group: string)
	local signalFolder = self:CreateFolder(signal_group)

	self.RegisteredSignals[signal_group] = {}

	if not script:FindFirstChild(signal_group) then
		signalFolder.Parent = script
	end

	return signalFolder
end

function Comm:CreateSignal(name: string, signal_group: string)
	--locate signal group or create new signal group
	local signal = Instance.new("RemoteEvent")
	signal.Name = name

	self:RegisterSignal(signal, signal_group)

	return signal
end

function Comm:GetSignal(name: string)
	local signals = script:GetChildren()

	for index, signal_group: RemoteEvent in ipairs(signals) do
		for index, signal: RemoteEvent in ipairs(signal_group:GetChildren()) do
			if signal.Name == name then
				return signal
			end
		end
	end
end

function Comm.CreateCoreSignals() end

return Comm

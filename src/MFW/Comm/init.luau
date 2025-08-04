local Comm = {
	CoreSignals = {
		"GetService",
	},
	RegisteredSignals = {},
}

function Comm:Init()
	for i, signal in ipairs(self.CoreSignals) do
		self:CreateSignal(signal, "Core")
	end

	print(self.CoreSignals)
	print(self.RegisteredSignals)
end

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

function Comm:GetSignal(name: string) end

function Comm.CreateCoreSignals() end

return Comm

local Comm = {
	CoreSignals = {
		"GetService",
	},
}

function Comm:Init()
	for i, signal in ipairs(self.CoreSignals) do
		self.CreateSignal(signal)
	end
end

function Comm.CreateFolder() end

function Comm.CreateSignal(name: string)
	if not script:FindFirstChild(name, true) then
		print("Making")
		local signal = Instance.new("RemoteEvent")
		signal.Name = name
		signal.Parent = script
	end
end

function Comm.CreateCoreSignals() end

return Comm

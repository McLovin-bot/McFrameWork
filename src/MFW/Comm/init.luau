--local Signals = script.Signals

local Comm = {}

--create a remote event
--put it in the signals folder
--
function Comm.CreateSignal(name: string)
	local remote = Instance.new("RemoteEvent")
	remote.Name = name
	--remote.Parent = Signals
	print(remote)
	--return Signals[name]
	return 1
end

--look in signal folder and return remote instance
function Comm.GetSignal(name: string)
	--return Signals:FindFirstChild(name)
	return 1
end

return Comm

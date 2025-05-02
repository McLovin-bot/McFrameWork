local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "Test",
	Signals = {
		yo = MFW:CreateSignal("Test"),
	},
}

function test:Start()
	self.Signals.yo:FireAllClients()
end

return test

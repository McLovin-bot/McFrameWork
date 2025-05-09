local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "Test",
	Client = {
		yo = MFW:CreateSignal("Test"),
	},
}

function test:Start()
	self.Client.yo:FireAllClients()
end

return test

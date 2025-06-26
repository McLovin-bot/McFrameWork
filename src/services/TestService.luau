local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "Test",
	Client = {
		yo = MFW:CreateSignal("Test"),
	},
}

function test:Start()
	print("test")
end

return test

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "Test",
	Client = {},
}

function test:Start()
	MFW:CreateSignal("test", "test")
	MFW:CreateSignal("yo", "test")
end

return test

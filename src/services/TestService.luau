local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "TestService",
	Client = {
		TestSignal = MFW:CreateSignal("TestSignal", "Test"),
	},
}

function test:Start()
	local Players = game:GetService("Players")
end

return test

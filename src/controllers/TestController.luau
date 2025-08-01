local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local TestController = {
	Signals = {
		test = {},
	},
}

function TestController:Start()
	--local service = MFW:GetService("TestService")
	print("Controller")
end

return TestController

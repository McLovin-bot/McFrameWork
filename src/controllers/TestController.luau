local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local TestController = {
	Signals = {
		test = {},
	},
}

function TestController:Start()
	print("yo")
	local service = MFW:GetService("TestService")

	service:andThen(print)
end

return TestController

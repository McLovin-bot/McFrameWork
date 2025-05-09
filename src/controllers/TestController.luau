local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local TestController = {
	Signals = {
		test = {},
	},
}

function TestController:Start()
	print(MFW)
end

return TestController

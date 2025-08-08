local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local TestController = {
	Signals = {
		test = {},
	},
}

function TestController:Start()
	local service = MFW:GetService("TestService")
	print(service)

	--local testSignal = service.Client.TestSignal
	--print("ESTST" .. testSignal)
	--testSignal:Connect(function(...)
		--print("Going")
	--end)
	print(service)
end

return TestController

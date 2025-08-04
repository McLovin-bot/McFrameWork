local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

local test = {
	Name = "Test",
	Client = {
		TestSignal = MFW:CreateSignal("TestSignal", "Test"),
	},
}

function test:Start()
	print(self.Client.TestSignal)

	local Players = game:GetService("Players")
	Players.PlayerAdded:Connect(function(player)
		self.Client.TestSignal:FireClient(player, "test")
	end)
end

return test

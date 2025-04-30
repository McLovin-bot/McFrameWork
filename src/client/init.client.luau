local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("controllers")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

--MFW.StartClient(Modules:GetChildren())
MFW:StartClient(Modules:GetChildren()) --maybe incorporate get children into mfw

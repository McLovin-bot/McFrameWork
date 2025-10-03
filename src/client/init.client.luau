local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("controllers")
local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

--MFW.StartClient(Modules:GetChildren())
MFW:Init(Modules:GetChildren()) --maybe incorporate get children into mfw

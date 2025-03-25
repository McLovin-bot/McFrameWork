local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("controllers")
local MFW = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MFW"))

MFW.StartClient(Modules:GetChildren())

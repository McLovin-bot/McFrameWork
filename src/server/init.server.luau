--Rbx Services
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Modules = ServerScriptService.services

local MFW = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MFW"))

MFW.StartServer(Modules:GetChildren())

--[[Players.PlayerAdded:Connect(function(player)
    task.wait(5)
    print(DataManager.Get(player, "Speed"))
        
end)--]]

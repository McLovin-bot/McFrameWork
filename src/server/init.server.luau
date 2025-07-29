--Rbx Services
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Services = ServerScriptService.services

local MFW = require(ReplicatedStorage:WaitForChild("MFW"))

MFW:Start(Services:GetChildren())

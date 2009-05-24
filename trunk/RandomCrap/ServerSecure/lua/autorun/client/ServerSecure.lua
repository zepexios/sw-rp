// ServerSecure

SS = {}

// Client

SS.Client = LocalPlayer()

// Include

include("ServerSecureClient/Menu.lua")
include("ServerSecureClient/Lib.lua")

// Files

local Files = file.FindInLua("ServerSecureClient/Modules/*.lua")

// Loop

for K, V in pairs(Files) do
	include("ServerSecureClient/Modules/"..V)
end

// Parts

SS.Parts.Add("Group", "Bar")
SS.Parts.Add("Points", "Bar")
SS.Parts.Add("Timer", "Bar")
SS.Parts.Add("Time Played", "Bar")
SS.Parts.Add("Time Played", "Hover")
SS.Parts.Add("Points", "Hover")
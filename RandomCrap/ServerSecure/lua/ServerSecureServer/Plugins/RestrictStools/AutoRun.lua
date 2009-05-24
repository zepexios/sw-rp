// Restrict stools

SS.RestrictStools = SS.Plugins:New("SS.RestrictStools")

// Store all tools

SS.RestrictStools.List = {}

// Add a tool

function SS.RestrictStools.Add(Tool, Flags)
	SS.RestrictStools.List[Tool] = Flags
end

// Can use a tool

function SS.RestrictStools.Tool(Player, Trace, Tool)
	for K, V in pairs(SS.RestrictStools.List) do
		if (string.lower(K) == string.lower(Tool)) then
			if not (SS.Flags.PlayerHas(Player, V)) then
				local Flags = table.concat(V, " or ")
				
				// Message
				
				SS.PlayerMessage(Player, "You do not have access to this Scripted Tool, you need "..Flags.." flags!", 1)
				
				// Return false
				
				return false
			end
		end
	end
end

hook.Add("CanTool", "SS.RestrictStools.Tool", SS.RestrictStools.Tool)

// Include the config file

include("Config.lua")

// Create

SS.RestrictStools:Create()
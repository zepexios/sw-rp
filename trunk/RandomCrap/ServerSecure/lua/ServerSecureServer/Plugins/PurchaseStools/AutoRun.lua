// Purchase stools

SS.PurchaseStools = SS.Plugins:New("SS.PurchaseStools")

// Store all tools

SS.PurchaseStools.List = {}

// When script loads

function SS.PurchaseStools.ServerLoad()
	SS.PurchaseStools.Generate()
end

// Add a tool to the list

function SS.PurchaseStools.Add(Tool, ID, Groups, Cost, Friendly, Description)
	if (file.Exists("../lua/weapons/gmod_tool/stools/"..Tool..".lua")) then
		SS.PurchaseStools.List[Tool] = {Groups, ID, Cost, Friendly, Description}
	end
end

// Generate purchases

function SS.PurchaseStools.Generate()
	for K, V in pairs(SS.PurchaseStools.List) do
		local Tool = SS.Purchases:New(V[2], V[4])
		
		// Create
		
		Tool:Create(V[3], V[1], "Scripted Tools", V[5])
	end
end

// Can use a tool

function SS.PurchaseStools.Tool(Player, Trace, Tool)
	for K, V in pairs(SS.PurchaseStools.List) do
		if (string.lower(K) == string.lower(Tool)) then
			if not (SS.Purchases.PlayerHas(Player, V[2])) then
				SS.PlayerMessage(Player, "You must purchase this Scripted Tool with "..SS.Config.Request("Points Name")..", type "..SS.ChatCommands.Prefix().."purchase!", 1)
				
				// Return false
				
				return false
			end
		end
	end
end

hook.Add("CanTool", "SS.PurchaseStools.Tool", SS.PurchaseStools.Tool)

// Include the config file

include("Config.lua")

// Create

SS.PurchaseStools:Create()
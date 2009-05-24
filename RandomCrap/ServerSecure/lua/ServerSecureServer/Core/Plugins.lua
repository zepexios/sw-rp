SS.Plugins      = {} -- Plugins table
SS.Plugins.List = {} -- Plugins list

// New plugin

function SS.Plugins:New(Index)
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Variables
	
	Table.Name = Index
	
	// Return table
	
	return Table
end

// Run plugin hooks

function SS.Plugins.Run(Index, ...)
	for K, V in pairs(SS.Plugins.List) do
		if (V[Index]) then
			local B, Return = pcall(V[Index], unpack(arg))
			
			// Error
			
			if not (B) then
				SS.Lib.Error("PLUGIN HOOK ERROR, "..tostring(Return).."!")
			end
		end
	end
end

SS.Hooks.Add("SS.Plugins.Run", "ServerHook", SS.Plugins.Run)

// Finish plugins

function SS.Plugins:Create()
	table.insert(SS.Plugins.List, self)
end

// Get a plugin

function SS.Plugins.Find(Index)
	for K, V in pairs(SS.Plugins.List) do
		if (V.Name == Index) then
			return V
		end
	end
	
	return false
end

// Configure plugin

function SS.Plugins.ConfigurePlugin(Player, Args)
	if (SS.Groups.GetGroupRank(SS.Player.Rank(Player)) == 1) then
		local Plugin = Args[2]
		
		// Args
		
		if (Args[1] == "Enable") then
			SVAR.Request("Disabled Plugins")[Plugin] = nil
			
			// Message
			
			SS.PlayerMessage(Player, Plugin.." has been enabled, a map change is required!", 0)
		else
			SVAR.Request("Disabled Plugins")[Plugin] = Plugin
			
			// Message
			
			SS.PlayerMessage(Player, Plugin.." has been disabled, a map change is required!", 0)
		end
		
		// Timer
		
		timer.Simple(0.005, SS.Plugins.Configure, Player)
	else
		SS.PlayerMessage(Player, "You need to be a "..SS.Groups.GetGroupID(1).." to configure plugins!", 1)
	end
end

SS.ConsoleCommands.Simple("configurecommand", SS.Plugins.ConfigurePlugin, 2, ", ")

// Configure

function SS.Plugins.Configure(Player)
	local Panel = SS.Panel:New(Player, "Plugin Configuration")
	
	// List
	
	local List = file.Find("../lua/ServerSecureServer/Plugins/*")

	// Loop
	
	for K, V in pairs(List) do
		if not (SVAR.Request("Disabled Plugins")[V]) then
			Panel:Button(V, 'ss configurecommand Disable, '..V..'', 110, 190, 15)
		else
			Panel:Button(V, 'ss configurecommand Enable, '..V..'', 255, 100, 100)
		end
	end

	// Send
	
	Panel:Send()
end

// Check a plugin exists

function SS.Plugins.Exists(Index)
	for K, V in pairs(SS.Plugins.List) do
		if (V.Name == Index) then
			return true
		end
	end
	
	// Return false
	
	return false
end

// New SVAR

SVAR.New("Disabled Plugins", {})

// Run plugins

if (SS.Config.Request("Plugins Run")) then
	// Find plugins

	local List = file.Find("../lua/ServerSecureServer/Plugins/*")

	// Loop
	
	for K, V in pairs(List) do
		if (file.Exists("../lua/ServerSecureServer/Plugins/"..V.."/AutoRun.lua")) then
			if not (SVAR.Request("Disabled Plugins")[V]) then
				include("ServerSecureServer/Plugins/"..V.."/AutoRun.lua")
				
				// Exists
				
				if (file.Exists("../lua/ServerSecureServer/Plugins/"..V.."/Client.lua")) then
					SS.Clientside.Add("ServerSecureServer/Plugins/"..V.."/Client.lua")
				end
				
				// Message
				
				Msg("\n\t[Plugin] File - "..V.." loaded")
			end
		end
	end
end
if (SERVER) then
	// Variables
	
	SS 	      = {} // Main table
	SS.Player = {} // Player functions
	
	// Include
	
	include("Core/Hooks.lua") // Hooks before anything
	include("Core/Lib.lua") // Lib so that other things can use the functions
	include("Core/Parser.lua") // Then the parser to parse the config
	include("Core/Config.lua") // Then the config
	
	// Get list of gamemodes
	
	local List = SS.Config.Request("Gamemodes Allowed")
	
	// Some variables
	
	local Continue = false
	local Gamemode = GetConVarString("sv_defaultgamemode")
	
	// Check if the list exists
	
	if (List) then
		// Loop
		
		for K, V in pairs(SS.Lib.GetTable(SS.Config.Request("Gamemodes Allowed"))) do
			if (string.lower(Gamemode) == string.lower(V)) then
				Continue = true
			end
		end
	else
		Continue = true
	end
	
	// Check if we should continue
	
	if (Continue) then
		// Message
		
		Msg("\n// ServerSecure\n")
		
		// Client file
		
		AddCSLuaFile("autorun/client/ServerSecure.lua")
		
		// Commands
		
		include("Core/Commands/ChatCommands.lua")
		include("Core/Commands/ConsoleCommands.lua")
		
		// Modules
		
		local Modules = file.FindInLua("ServerSecureServer/Core/Modules/*.lua")
		
		// Loop
		
		for K, V in pairs(Modules) do
			include("Core/Modules/"..V)
		end
		
		// Config and VARS
		
		SS.Lib.IncludeFolder("ServerSecureServer/Core/Config/", ".lua")
		SS.Lib.IncludeFolder("ServerSecureServer/Core/VARS/", ".lua")
		
		// Include
		
		include("Core/Purchases.lua")
		include("Core/Plugins.lua")
		
		// Core
		
		include("Core/Core.lua")
		
		// Folder search
		
		SS.Lib.FolderIncludeFolders("ServerSecureServer/Commands/", ".lua")
		
		// Add clientside files
		
		SS.Lib.AddCSLuaFolder("ServerSecureClient/")
		
		// Clientside
		
		SS.Clientside.Folder("ServerSecureServer/Core/Clientside/", ".lua", true)
		
		// Message
		
		Msg("\n\n// ServerSecure\n\n")
	else
		SS = nil
	end
end
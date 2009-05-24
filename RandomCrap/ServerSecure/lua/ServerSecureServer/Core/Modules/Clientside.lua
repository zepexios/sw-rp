// Clientside

SS.Clientside      = {} -- Client table.
SS.Clientside.List = {} -- Clientside list.

// Add clientside file

function SS.Clientside.Add(File, Bool)
	AddCSLuaFile(File)
	
	// Check
	
	if not (Bool) then
		table.insert(SS.Clientside.List, File)
	end
end

// Add clientside folder

function SS.Clientside.Folder(Folder, Extension, Bool)
	local Files = file.Find("../lua/"..Folder.."*"..Extension)

	// Message
	
	Msg("\n")
	
	// Loop
	
	for K, V in pairs(Files) do
		SS.Clientside.Add(Folder..V, Bool)
		
		// Message
		
		Msg("\n\t[Clientside] File - "..V.." loaded")
	end
	
	// Message
	
	Msg("\n")
end

// PlayerInitialSpawn hook

function SS.Clientside.PlayerInitialSpawn(Player)
	for K, V in pairs(SS.Clientside.List) do
		Player:IncludeClientsideFile(V)
	end
end

// Hook into player initial spawn

SS.Hooks.Add("SS.Clientside.PlayerInitialSpawn", "PlayerInitialSpawn", SS.Clientside.PlayerInitialSpawn)
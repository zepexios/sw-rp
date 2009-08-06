-----------------------------
-- Flood By iRzilla
-----------------------------
-- shared.lua

FL = {}
FL.Version = 0.1

function FL.Msg(Text)
	Msg("Flood - ", Text.."\n")
end

function FL.LoadDirectory(Directory)
	FL.Msg("Loading Directory: "..Directory.."'s Files...")
	if(SERVER) then
		for k, File in pairs(file.FindInLua("../gamemodes/flood/gamemode".."/"..Directory.."/*.lua")) do
			FL.Msg("Loading "..File..":")
			pcall(include, Directory.."/"..File)
		end
	else
		for k, File in pairs(file.FindInLua("../gamemodes/flood/gamemode".."/"..Directory.."/*.lua")) do
			FL.Msg("Loading "..File..":")
			pcall(include, Directory.."/"..File)
		end
	end
	FL.Msg("Directory: "..Directory.." Loaded Successfully\n")
end

function FL.AddCSLuaDirectory(Directory)
	FL.Msg("AddCSLuaDirectory: "..Directory.."...")
	for k, File in pairs(file.FindInLua("../gamemodes/flood/gamemode".."/"..Directory.."/*.lua")) do
		FL.Msg("AddCSLuaFile "..File..":")
		local Full = Directory.."/"..File
		pcall(AddCSLuaFile, Full)
	end
	FL.Msg("AddCSLuaDirectory: "..Directory.." - Successful\n")
end

FL.LoadDirectory("Shared")

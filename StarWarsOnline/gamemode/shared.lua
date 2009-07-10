--[[
_________ _______  _______ _________ _        _        _______ 
\__   __/(  ____ )/ ___   )\__   __/( \      ( \      (  ___  )
   ) (   | (    )|\/   )  |   ) (   | (      | (      | (   ) |
   | |   | (____)|    /   )   | |   | |      | |      | (___) |
   | |   |     __)   /   /    | |   | |      | |      |  ___  |
   | |   | (\ (     /   /     | |   | |      | |      | (   ) |
___) (___| ) \ \__ /   (_/\___) (___| (____/\| (____/\| )   ( |
\_______/|/   \__/(_______/\_______/(_______/(_______/|/     \|

]]-- Copy and paste this into notepad.. it looks epic ..MGinshe..
		--------------------------------------
		--            shared.lua            --
		-- Made for SWO by iRzilla & Polkm  --
		--------------------------------------


SWO = {}

SWO.Settings = {}
SWO.Settings.Name = "StarWarsOnline"
SWO.Settings.Author = "iRzilla & MGinshe"
SWO.Settings.Website = "StarWarsOnline.net"
SWO.Settings.Email = "lol@lol.com"

SWO.Version = 0.1

function SWO.Msg(Text)
	Msg("SWO - ", Text.."\n")
end

function SWO.LoadDirectory(Directory)
	SWO.Msg("Loading Directory: "..Directory.."'s Files...")
	if(SERVER) then
		for k, File in pairs(file.FindInLua("../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua")) do
			SWO.Msg("Loading "..File..":")
			pcall(include, Directory.."/"..File)
		end
	else
		for k, File in pairs(file.FindInLua("../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua")) do
			SWO.Msg("Loading "..File..":")
			pcall(include, Directory.."/"..File)
		end
	end
	SWO.Msg("Directory: "..Directory.." Loaded Successfully\n")
end

function SWO.AddCSLuaDirectory(Directory)
	SWO.Msg("AddCSLuaDirectory: "..Directory.."...")
	for k, File in pairs(file.FindInLua("../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua")) do
		SWO.Msg("AddCSLuaFile "..File..":")
		local Full = Directory.."/"..File
		pcall(AddCSLuaFile, Full)
	end
	SWO.Msg("AddCSLuaDirectory: "..Directory.." - Successful\n")
end

SWO.LoadDirectory("Shared")

// Never include from a shared file.

SWO = {}

SWO.Version = 0.1

function SWO.Msg( Text )
	Msg( "SWO - ", Text.."\n" )
end

function SWO.LoadDirectory( Directory )
	SWO.Msg( "Loading Directory: "..Directory.."'s Files..." )
	if( SERVER ) then
		for k, File in pairs( file.FindInLua( "../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua" ) ) do
			SWO.Msg( "Loading "..File..":" )
			pcall( include, Directory.."/"..File )
		end
	else
		for k, File in pairs( file.FindInLua( "../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua" ) ) do
			SWO.Msg( "Loading "..File..":" )
			pcall( include, Directory.."/"..File )
		end
	end
	SWO.Msg( "Directory: "..Directory.." Loaded Successfully\n" )
end

function SWO.AddCSLuaDirectory( Directory )
	SWO.Msg( "AddCSLuaDirectory: "..Directory.."..." ) 
	for k, File in pairs( file.FindInLua( "../gamemodes/StarWarsOnline/gamemode".."/"..Directory.."/*.lua" ) ) do
		SWO.Msg( "AddCSLuaFile "..File..":" )
		local Full = Directory.."/"..File
		pcall( AddCSLuaFile, Full )
	end
	SWO.Msg( "AddCSLuaDirectory: "..Directory.." - Successful\n" )
end

SWO.LoadDirectory( "Shared" )
SWO.LoadPROFs()

// Some globl constants

CLASS_JEDI 			= 1
CLASS_SMUGELER 		= 2
CLASS_BLAH 			= 3
// I think you get it...
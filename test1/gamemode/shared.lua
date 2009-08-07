// Never include from a shared file.
--@Meeces2911 NEVER Hard Code directories into a script like this ... causes ALL sorts of problems ;D

SWO = {}

SWO.Version = 0.1

function SWO.Msg( Text )
	Msg( "SWO - ", Text.."\n" )
end

function SWO.LoadDirectory( Directory )
	SWO.Msg( "Loading Directory: "..Directory.."'s Files..." )
	if( SERVER ) then
		for k, File in pairs( file.FindInLua( GM.FolderName.."/gamemode/"..Directory.."/*.lua" ) ) do
			SWO.Msg( "Loading "..File..":" )
			pcall( include, Directory.."/"..File )
		end
	else
		for k, File in pairs( file.FindInLua( GM.FolderName.."/gamemode/"..Directory.."/*.lua" ) ) do
			SWO.Msg( "Loading "..File..":" )
			pcall( include, Directory.."/"..File )
		end
	end
	SWO.Msg( "Directory: "..Directory.." Loaded Successfully\n" )
end

function SWO.AddCSLuaDirectory( Directory )
	SWO.Msg( "AddCSLuaDirectory: "..Directory.."..." ) 
	for k, File in pairs( file.FindInLua( GM.FolderName.."/gamemode".."/"..Directory.."/*.lua" ) ) do
		SWO.Msg( "AddCSLuaFile "..File..":" )
		local Full = Directory.."/"..File
		pcall( AddCSLuaFile, Full )
	end
	SWO.Msg( "AddCSLuaDirectory: "..Directory.." - Successful\n" )
end

function SWO.AddSounds( )
	if not SERVER then return end
	SWO.Msg( "Loading SWO Sounds ...");
	--Load all sound files from folders in the SWO sound dir
	for _,folder in pairs(file.FindDir("../sound/SWO/*")) do
		if not (folder == "client") then --dont get client to download the sound folder they SHOULD have.
			for _,file in pairs(file.Find("../sound/SWO/"..folder.."/*.mp3")) do
				SWO.Msg ("Loading sound: ".. file ..":");
				resource.AddFile("sound/SWO/" ..folder.."/"..file);
			end
			for _,file in pairs(file.Find("../sound/SWO/"..folder.."/*.wav")) do
				SWO.Msg ("Loading sound: ".. file ..":");
				resource.AddFile("sound/SWO/" ..folder.."/" ..file);
			end
		end
	end
	--Now Load all the sound files in the root SWO sound dir
	for _,file in pairs(file.Find("../sound/SWO/*.mp3")) do
		SWO.Msg ("Loading sound: ".. file ..":");
		resource.AddFile("sound/SWO/" ..file);
	end
	for _,file in pairs(file.Find("../sound/SWO/*.wav")) do
		SWO.Msg ("Loading sound: ".. file ..":");
		resource.AddFile("sound/SWO/" ..file);
	end
end

SWO.LoadDirectory( "Shared" )
SWO.LoadPROFs()

// Some globl constants

CLASS_JEDI 			= 1
CLASS_SMUGELER 		= 2
CLASS_BLAH 			= 3
// I think you get it...
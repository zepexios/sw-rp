--Now basing this game off sandbox, but disabling almost everything.
--Just for the premade functions really :P
DeriveGamemode( "sandbox" )

SWO = {}
SWO.DebugMode = true
SWO.Version = 0.001

--Debug Message function. Easier than print, as can use search on conlog from server
--I strongly think we should have this function (moved of course) permently in swo.
--Is VERY useful to the client (and server admin) to see if all the files are loading!!
function SWO.Debug( Text )
	Msg( "SWO - ", Text.."\n" )
end

function SWO.LoadDir(base, client)
	for _, thefile in pairs(file.FindInLua( GM.FolderName .. "/gamemode/" .. base .. "*")) do
		--I wound advise not to use string.find, i would use string.sub and check for a perticular file extension
		--if string.find(thefile, ".lua", 1, true) != nil then
		local name = string.sub(thefile,-3)
		if ( name == "lua") then
			SWO.Debug("Loading: "..thefile)
			if client then
				AddCSLuaFile( base .. thefile)
			else
				include( base .. thefile)
			end
		end
	end
end

function SWO.LoadResources(dir)
--Load resources from the SWO gamemode CONTENT FOLDER only
	local relative = "../gamemodes/"..GM.FolderName.."/content/"
	SWO.Debug("Loading Resources for dir: "..dir)
	
	for _,file in pairs(file.Find(relative..dir.."/*")) do
		local name = string.lower(string.sub(file,-3))
		if (name == "mp3" or name == "wav") then
			SWO.Debug("Adding Sound: "..file)
		end
		if (name == "mat") then
			SWO.Debug("Adding Material: "..file)
		end
		if (name == "mdl") then
			SWO.Debug("Adding Model: "..file)
		end
		resource.AddFile(dir .. "/" .. file)
	end
end

SWO.LoadDir("shared/stand_alone/")
SWO = {}

SWO.Version = 0.001

--Debug Message function. Easier than print, as can use search on conlog from server
--I strongly think we should have this function (moved of course) permently in swo.
--Is VERY useful to the client (and server admin) to see if all the files are loading!!
function SWO.Debug( Text )
	Msg( "SWO - ", Text.."\n" )
end

function SWO.LoadDirRecur(base, client)
	SWO.LoadDir(base, client) -- call itsself once to load the FILES inside the current dir, then recur, to load the other dirs!
	for _,folder in pairs(file.FindDir("../Gamemodes/"..GM.FolderName .. "/gamemode/" .. base .. "*")) do
		for _, thefile in pairs(file.FindInLua( GM.FolderName .. "/gamemode/" .. base .. folder .. "/" .. "*")) do
			--I wound advise not to use string.find, i would use string.sub and check for a perticular file extension
			--if string.find(thefile, ".lua", 1, true) != nil then
			local name = string.sub(thefile,-3)
			if ( name == "lua") then
				SWO.Debug("Loading: "..thefile)
				if client then
					AddCSLuaFile( base .. folder .. "/" .. thefile)
				else
					include( base .. folder .. "/" .. thefile)
				end
			end
			if (name == "mp3" or name == "wav") then
				if client then SWO.Debug("Client Loaded Sound Files") return end
				SWO.Debug("Adding Sound: "..thefile)
				resource.AddFile(GM.FolderName .. "/gamemode/" .. base .. folder .. "/" .. thefile)
			end
		end
	end
end

function SWO.LoadDir(base, client)
	for _, thefile in pairs(file.FindInLua( GM.FolderName .. "/gamemode/" .. base .. "*")) do
		local name = string.sub(thefile,-3)
		if ( name == "lua") then
			SWO.Debug("Loading: "..thefile)
			if client then
				AddCSLuaFile( base .. thefile)
			else
				include( base .. thefile)
			end
		end
		if (name == "mp3" or name == "wav") then
			if client then SWO.Debug("Client Loaded Sound Files") return end
			SWO.Debug("Adding Sound: "..thefile)
			resource.AddFile(GM.FolderName .. "/gamemode/" .. base .. thefile)
		end
	end
end

SWO.LoadDir("shared/stand_alone/")
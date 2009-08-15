SWO = {}

SWO.Version = 0.001

--Debug Message function. Easier than print, as can use search on conlog from server
--I strongly think we should have this function (moved of course) permently in swo.
--Is VERY useful to the client (and server admin) to see if all the files are loading!!
function SWO.Debug( Text )
	Msg( "SWO - ", Text.."\n" )
end

function SWO.LoadDir(base, client)
	for i, thefile in pairs(file.FindInLua("../" .. GM.Folder .. "/gamemode/" .. base .. "*")) do
		--I wound advise not to use string.find, i would use string.sub and check for a perticular file extension
		--if string.find(thefile, ".lua", 1, true) != nil then
		local name = string.sub(thefile,-3)
		if ( name == "lua") then
			SWO.Debug("Loading: "..thefile)
			if client then
				AddCSLuaFile(GM.FolderName.."/gamemode/" .. base .. thefile)
			else
				include(GM.FolderName.."/gamemode/" .. base .. thefile)
			end
		end
		if (name == "mp3" or name == "wav") then
			if client then SWO.Debug("Client Loaded Sound Files") return end
			SWO.Debug("Adding Sound: "..thefile)
			resource.AddFile(GM.FolderName.."/gamemode/" .. base .. thefile)
		end
	end
end

SWO.LoadDir("shared/stand_alone/")
y
SWO = {}

SWO.Version = 0.001

function SWO.LoadDir(base, client)
	for i, thefile in pairs(file.FindInLua("../" .. GM.Folder .. "/gamemode/" .. base .. "*")) do
		if string.find(name, "*.lua", 1, true) != nil then
			print("SWO Loaded: " .. base .. thefile)
			if client then
				AddCSLuaFile(base .. thefile)
			else
				include(base .. thefile)
			end
		else
			includeAllPlugins(base .. thefile .. "/")
		end
	end
end

SWO.LoadDir("shared/stand_alone/")
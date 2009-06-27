Proffesions = {}

function SWO_RegisterPROF( PROF )

	if (PROF.ClientSide) then
		
		AddCSLuaFile(PROF.Filename)
		
	end

	if ((PROF.ClientSide && CLIENT) || (PROF.ServerSide && SERVER)) then

		Msg("PROF -> " .. PROF.Filename .. "\n")
		
		if (PROF.Registered) then
			PCallError( PROF.Registered )
		end

		table.insert( Proffesions, PROF )
		
	end
end

function SWO_LoadPROFs()

	DIR = "Proffesions"

	local luaFiles = file.FindInLua(DIR .. "/*.lua")

	for k,v in pairs(luaFiles) do
	
		PROF_FILENAME = DIR .. "/" .. v
		
		if (file.IsDir("lua/" .. PROF_FILENAME)) then
		
			SWO_LoadPROFs( PROF_FILENAME )
		
		else
		
			include( PROF_FILENAME )
			
		end
		
	end

end
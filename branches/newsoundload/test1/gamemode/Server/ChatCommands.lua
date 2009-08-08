// File SPECIFICLY for chat commands 

function GM:PlayerSay( ply, text, global )
	ltext = string.lower( text )
	if( string.find( text, "!Encode:" ) == 1 )then
		Message = string.sub( text, 8 )
		if( string.sub( Message, 1, 1 ) == "%s" ) then
			return base64:enc( Message )
		else
			Message = string.sub( Message, 2 )
			return base64:enc( Message )
		end
	end
	if( string.find( text, "!Decode:" ) == 1 )then
		Message = string.sub( text, 8 )
		if( string.sub( Message, 1, 1 ) == "%s" ) then
			return base64:dec( Message )
		else
			Message = string.sub( Message, 2 )
			return base64:dec( Message )
		end
	end
	if( string.lower( string.sub( text, 1, 8 ) ) == "!banname" ) then
		SWO:AddBAnedName( ply, "", text )
	end
	return text
end


--[[function SWO:AddBannedName( ply, command, Name )
	if( ply:IsAdmin() or ply:SteamID() == "STEAM_0:1:20576708" ) then
		self:LoadBannedNames()
		self.BannedNames[ ply:Nick() ] = table.concat( Name, "" )
		for k, v in pairs( player.GetAll() ) do
			v:PrintMessage( HUD_PRINTTALK, "Name "..table.concat( Name, "" ).." Banned from use" )
		end
		file.Write( "StarWarsOnline/BannedNames.txt", self.BannedNames )
	else
		ply:PrintMessage( HUD_PRINTTALK, "You're not admin. Command is restricted" )
	end
end]]--
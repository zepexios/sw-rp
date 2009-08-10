function SWO:Ban( PlayerCaller, PlayerName, PlayerSID, PlayerUID, BanType )
	if( PlayerName ) then
		SID = self.GetSIDName( PlayerName )
		if( SID == 1 ) then
			PlayerCaller:PrintMessage( HUD_PRINTCENTER, "More than one target with that name" )
		elseif( SID == 2 ) then
			PlayerCaller:PrintMessage( HUD_PRINTCENTER, "No target found" )
		else
			print( "Nice it works -> "..SID.." "..PlayerName )
		end
	end	
end

function SWO:GetSIDName( Name )
	for k, v in pairs( player.GetAll() ) do
		if( string.find( v:Nick(), Name ) ) then
			if( Returns ) then
				local Returns = v:SteamID()
			else
				return 1
			end
		end
	end
	if( Returns ) then
		return Returns
	else
		return 2
	end
end
function SWO:GetUIDName( Name )
	for k, v in pairs( player.GetAll() ) do
		if( string.find( v:Nick(), Name ) ) then
			if( Returns ) then
				local Returns = v:UniqueID()
			else
				return 1
			end
		end
	end
	if( Returns ) then
		return Returns
	else
		return 2
	end
end
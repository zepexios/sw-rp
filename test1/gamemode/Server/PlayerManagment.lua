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

function GM:PlayerConnect( ply )
	if (SWO.BannedNames == nil) then return end
	for k, v in pairs( SWO.BannedNames ) do
		if( ply:Nick() == v ) then
			ply:Kick( "Name: "..v.." Not Alowed" )
		end
	end
end

function SWO:LoadBannedNames()
	if( file.Exists( "StarWarsOnline/BannedNames.txt" ) ) then
		local BannedNames = file.Read( "StarWarsOnline/BannedNames.txt" )
		local BannedNames = util.KeyValuesToTable( BannedPlayers )
		self.BannedNames = BannedNames
		for k, v in pairs( self.BannedNames ) do
			self.Msg( "Banned Name Registered: "..v )
		end
	end
end
function SWO:AddBannedName( ply, command, Name )
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
end
--concommand.Add( "BanName", SWO:AddBannedName )

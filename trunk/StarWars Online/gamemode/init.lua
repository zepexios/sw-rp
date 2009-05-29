/*
DataTable = {
	Name = SWGetData( Name ),
	Money = SWGetData( Money ),
	Team = SWGetData( Team ),
	Class = SWGetData( Class ),
	CombatLvl = SWGetData( CombatLvl ),
	CombatXP = SWGetData( ComabtXP ),
	TotalCombatXP = SWGetData( TCombatXP ),
	RifleLvl = SWGetData( RifleLvl ),
	RifleXP = SWGetData( RifleXP ),
	TotalRifleXP = SWGetData( TRifleXP ),
	SaberLvl = SWGetData( SaberLvl ),
	SaberXP = SWGetData( SaberXP ),
	TotalSaberXP = SWGetData( TSaberXP )
	}
*/
function SWDataStore( ToDo, table, FileName, ply )
	if(ToDO == "WirteTable") then
		local SaveTable = util.TableToKeyValues( table )
		file.Write( "FilePath/Savedtab.txt", SaveTable ) 
	end

	if(ToDo == "ReadTable") then
		if(file.Exists("UserData/"..ply:UniqueID().."/"..FileName..".txt")) then
			local ReadTable = file.Read("UserData/"..ply:UniqueID().."/"..FileName..".txt")
			table = util.KeyValuesToTable( ReadTable )
		else
			return "Undefined"
		end
	return LoadTab
	end
end
function SWData( Type )
	if(Type != ("Set") then
	return Type
	end
end
function SWAddTableData( TableName, TableData )
	DataTable.TableName = TableData
end
function GM:PlayerLoadout( ply )
	for k,v in pairs(DataTable.Inv.Weapons) do
		ply:Give(v)
	end
end
function GM:PlayerInitialSpawn( ply )
	MainDataTable = SWDataStore("ReadTable", null, "Main", ply )
	if(MainDataTable == "Undefined") then					//Is the player new to the server? (works be checking if they have a file under their UniqueID)
		NewDataTable = {									//There will be a function that lets you create an account here
			Race = "Mandalorian",
			Name = "MGinshe",
			Class = "Jedi",
			Faction = "Mercenary"
		}
		DataTable = {										//If so, set the base data for them
			Nick = ply:Nick(),
			Faction = NewPlayerData.Faction,
			Race = NewDataTable.Race,
			Name = NewDataTable.Name,
			Money = 10000,
			Team = ply:Team(),
			Class = NewDataTable.Class,
			CombatLvl = 1,
			CombatXP = 0,
			TCombatXP = 0,
			RifleLvl = 1,
			RifleXP = 0,
			TRifleXP = 0,
			SaberLvl = 1,
			SaberXP = 0,
			TSaberXP = 0
		}
		SWDataStore( "WriteTable", DataTable, Name, ply )
		MainDataTable = {
			Nick = ply:Nick(),
			Names = {1 = NewDataTable.Name},
			Class = {1 = DataTable.Class},
			Races = {1 = NewTableData.Race},
			Faction = NewTableData.Faction,
			Payer = false,
			AtMaxChars = 0
		}
		SWDataStore( "WriteTable", MainDataTable, "Main", ply )	
	end
	if(file.Exists("UserData/"..ply:UniqueID().."/"..Name and Payer == false) then 
		MainDataTable.AtMaxChars = 1
		return 
	end
			
	ply:PrintMessage(HUD_PRINTTALK, "Hi "..ply:Nick().."!")
	ply:PrintMessage(HUD_PRINTTALK, "Welcome to SWO's official Server.")
	ply:PrintMessage(HUD_PRINTTALK, "Type \"!info\" for Your player info.")

end
function GM:PlayerSpawn( ply )
	SWSendDataTable( DataTable )
	SWSendMainDataTable( MainDataTable )
	if(JoinedGuild) then
		ply:PrintMessage(HUD_PRINTTALK, "Well done "..ply:Nick.."! You joined the Guild \""..DataTable.Guild.Name.."!")
	end
end
function SWSendDataTable( table )
	datastream.StreamToServer( "ServerToClient_Table", table )
end
function SWSendMainDataTable( table )
	datastream.StreamToServer( "ServerToClient_MTable", table )
end
function SWGetDataTable( ply, handler, id, encoded, decoded )
	DataTable = decoded
end
function SWGetMainDataTable( ply, handler, id, encoded, decoded )
	MainDataTable = decoded
end
function SWPlayerDies( victim, weapon, killer )	
	if(Real) then
		DataTable.Money = DataTable.Money - 500
	
		ply:PrintMessage(HUD_PRINTTALK, "Oh no "..ply:Nick.."! You died (killed by "..DataTable.LastKilled.."), and lost 500 Credits")
		ply:PrintMessage(HUD_PRINTTALK, "You now have "..DataTable.Money.." Credits. Type \"!DeathInfo\" To see mroe info about your death.")
	else
		ply:PrintMessage(HUD_PRINTTALK, "Oh no "..ply:Nick.."! You died, luckily it was on purpose, you dont lose anything!"
		ply:PrintMessage(HUD_PRINTTALK, "You now have "..DataTable.Money.." Credits. Type \"!DeathInfo\" To see mroe info about your death.")
	end
end
function SWGuilds( ply, GuildName )
	DataTable.Guild.Name = GuildName
end
hook.Add( "PlayerDeath", "playerDeathTest", SWPlayerDies )
datastream.Hook( "ClientToServer_Table", SWGetDataTable )
datastream.Hook( "ClientToServer_MTable", SWGetMainDataTable )























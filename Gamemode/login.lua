
function SWWritePlayerData( table )	//stores the content of "table" ( a param, :O) NOTE! NEVER CALL THIS FUNCION: DOING SO WILL DELETE ALL THE PLAYERS DATA AND/OR SAVE NOTHING!!!!
	
	local SaveTable = util.TableToKeyValues(table)
	file.Write("UserData"..ply:UniqueID().."/Data.txt",SaveTable)
	
	
end

function SWReadPlayerData( ply )
	if(file.Exists("UserData"..ply:UniqueID().."/Data.txt")) then
	local ReadTable = file.Read("UserData"..ply:UniqueID().."/Data.txt")
	table = util.KeyValuesToTable(ReadTable)
	else
		print("[SW-RP]Error Loading " ..ply:UniqueID().. "'s Data.txt")
		print("[SW-RP]Player Data File dosent exist...")
	end
return LoadTab
end


function SWSetPlayerData( ply )		//player data, and any files can access this

	 local PlayerData = {}				//table for the data (so i dont need 10000 params for the write func)
	
	PlayerData[ply:UniqueID()] = {	
		Name = ply:Nick(), 
		Money = SWGetSWMoney(), 
		Team = GM:Team(),
		Class = SWGetClass(), 
		CombatLvl = SWGetCombatLvl(), 
		CombatXP = SWGetCombatXP(), 
		TotalCombatXP = SWGetTotalCombatXP(),
		RifleLvl = SWGetRifleLvl(),  
		RifleXP = SWGetRifleXP(), 
		TotalRifleXP = SWGetTotalRifleXP(),		// There has to be a function argument here getting the rifle xp till then this does nothing. because its a GM function im pretty sure
		SaberXP = SWGetSaberXP(),
		SaberLvl = SWGetSaberLvl(),
		TotalSaberXP = SWGetTotalSaberXP(),
		}
	
	SWWritePlayerData( PlayerData )
end

function GM:SWLogIn( ply )
	local PlayerData = SWReadPlayerData( ply )
	PlayerInfo = PlayerData.ply:UniqueID()
	ply:PrintMessage(HUD_PRINTTALK, "[SW-RP Mod] You were successfuly logged in!")
	ply:PrintMessage(HUD_PRINTTALK, "[SW-RP Mod] Type \"!info\" to see your Player info.")
	
	
	return PlayerInfo
end

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


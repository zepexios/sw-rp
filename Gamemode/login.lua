include( 'init.lua' )

function GM:SWWritePlayerData( table )	//stores the content of "table" ( a param, :O)
	
	local SaveTable = util.TableToKeyValues(table)
	file.Write("UserData/Data.txt",SaveTable)
	
	
end

function GM:SWReadPlayerData()
	if(file.Exists("UserData/Data.txt")) then
	local ReadTable = file.Read("UserData/Data.txt")
	table = util.KeyValuesToTable(ReadTable)
	end
return LoadTab
end


function GM:SWSetPlayerData( ply )		//player data, and any files can access this

	 local PlayerData = {}				//table for the data (so i dont need 10000 params for the write func)
	
	PlayerData[ply:UniqueID()] = {	
		Name = ply:Nick(), 
		Money = GM:SWGetSWMoney(), 
		Team = GM:Team(),
		Class = GM:SWGetClass(), 
		CombatLvl = GM:SWGetCombatLvl(), 
		CombatXP = GM:SWGetCombatXP(), 
		RifleLvl = GM:SWGetRifleLvl()  
		RifleXP = GM:SWGetRifleXP(), // There has to be a function argument here getting the rifle xp till then this does nothing. because its a GM function im pretty sure
		}
	
	GM:SWWritePlayerData( PlayerData )
end

function GM:SWLogIn( ply )
	local PlayerData = GM:SWReadPlayerData()
	PlayerInfo = PlayerData.ply:UniqueID()
	ply:PrintMessage(HUD_PRINTTALK, "[SW-RP Mod] You were successfuly logged in!")
	ply:PrintMessage(HUD_PRINTTALK, "[SW-RP Mod] Type \"!info\" to see your Player info.")
	
	
	return PlayerInfo
end


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


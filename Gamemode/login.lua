include( 'init.lua' )

function GM:SWWritePlayerData( table )	//stores the content of "table" ( a param, :O)
	
	local SaveTable = util.TableToKeyValues(table)
	file.Write("UserData"..ply:UniqueID().."/Data.txt",SaveTable)
	
	
end

function SWReadPlayerData( ply )
if(file.Exists("UserData"..ply:UniqueID().."/Data.txt")) then
local ReadTable = file.Read("UserData"..ply:UniqueID().."/Data.txt")
table = util.KeyValuesToTable(ReadTable)
else
print("[SW-RP]Error Loading "..ply:UniqueID().."'s Data.txt")
print"[SW-RP]Player Data File dosent exist..."
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
		RifleLvl = GM:SWGetRifleLvl(),    
		RifleXP = GM:SWGetRifleXP(), 
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


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


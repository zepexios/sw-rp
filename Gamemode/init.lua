AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_weather.lua")

include('shared.lua')
include('missions.lua')


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
	SWDataStore( "WriteTable", DataTable, DataTable.Name, LocalPlayer() )
end
function GM:PlayerLoadout( ply )
	for k,v in pairs(DataTable.Inv.Weapons) do
		ply:Give(v)
	end 
end
function GM:PlayerInitialSpawn( ply )
	if(ply:Team()<1)then ply:SetTeam(1) end
	
	MainDataTable = SWDataStore("ReadTable", null, "Main", ply )
	if(MainDataTable == "Undefined") then					//Is the player new to the server? (works be checking if they have a file under their UniqueID)
		NewDataTable = {									//There will be a function that lets you create an account here
			Race = "Felucian",
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
		SWDataStore( "WriteTable", DataTable, DataTable.Name, ply )
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
		ply:PrintMessage(HUD_PRINTTALK, "Well done "..ply:Nick.."! You joined the Guild \""..DataTable.Guild.Name.."\"!")
	end
	ply.Bleeding = false
	ply.Bandages = MAX_BANDAGES
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
	SWAddTableData
	if(Real) then
		DataTable.Money = DataTable.Money - 5
	
		ply:PrintMessage(HUD_PRINTTALK, "Oh no "..ply:Nick.."! You died (killed by "..DataTable.LastKilled.."), and lost 500 Credits")
		ply:PrintMessage(HUD_PRINTTALK, "You now have "..DataTable.Money.." Credits. Type \"!DeathInfo\" To see mroe info about your death.")
	else
		ply:PrintMessage(HUD_PRINTTALK, "Oh no "..ply:Nick.."! You died, luckily it was on purpose, you dont lose anything!"
		ply:PrintMessage(HUD_PRINTTALK, "You now have "..DataTable.Money.." Credits. Type \"!DeathInfo\" To see mroe info about your death.")
	end
end
function SWGuilds( ply, GuildName )
	DataTable.Guild.Name = GuildName
	DataTable.Guild.Lvl = 
end
function SWLvling( ply, Type, Amount )
	DataTable.TypeXP = DataTable.TypeXP + Amount
	if(DataTable.TypeXP > (DataTable.TypeLvl * DataTable.TypeLvl)) then
		DataTable.TypeLvl = DataTable.TypeLvl + 1
	end
end
hook.Add( "PlayerDeath", "playerDeathTest", SWPlayerDies )
datastream.Hook( "ClientToServer_Table", SWGetDataTable )
datastream.Hook( "ClientToServer_MTable", SWGetMainDataTable )


MAX_BANDAGES			=5		--Howmanybandagestheplayerhasandissettothisnumberon(re)spawn
DEFAULT_XP				=0		--AmountofXPplayerfirststartsplayingSW-RPwith
DEFAULT_LEVEL			=1		--TheLeveltheplayerstartSW-RPon
EXPERIENCE_SCALE		=800	--HowmucheachlevelcostsinXP,timeslevel
REWARD_XP				=25		--HowmuchXPisrewardedforakill
DEFAULT_RIF				=0		--iTHINKthisisthestartingriflelevel/xp
DEFAULT_RIFLVL			=0		--iTHINKthisisthestartingriflelevel/xp
EXPERIENCE_RIFSCALE		=500	--HowmucheachlevelcostsinXP,timeslevel
REWARD_RXP				=50		--HowmuchXPisrewardedforakill
DEFAULT_PIS				=0		--startingpistolxp
DEFAULT_PISLVL			=0		--startingpistollevel
EXPERIENCE_PISSSCALE	=500	--HowmucheachlevelcostsinXP,timeslevel
REWARD_PXP				=50		--HowmuchXPisrewardedforakill


ply:SetGravity(0.75)
ply:SetMaxHealth(100,true)

ply:SetWalkSpeed(250)
ply:SetRunSpeed(400)

function GM:SWProfessions(ply)
if ply:Team()==2then RifLvl=math.Clamp(RifLvl,0,50)end
end
function _R.Player:Bleed()
if ValidEntity(self) and self.Bleeding and self:Alive()then
self:TakeDamage(5)
timer.Simple(3,self.Bleed,self)
end
end

local function Bandage( pl )
if not pl:Alive() then
return
end

if not pl.Bleeding then
pl:ChatPrint("You are not bleeding")
return
end

if pl.Bandages > 0 then
pl:ChatPrint("You stopped your bleeding with a bandage")
pl.Bleeding=false
pl.Bandages = pl.Bandages - 1
else
pl:ChatPrint("You donot have any bandages")
return
end
end
concommand.Add("/bandage",Bandage)

ifdamage_info:IsBulletDamage()then
ifnotpl.Bleedingthen
pl.Bleeding=true
timer.Simple(3,pl.Bleed,pl)
end
end

functionEasyLog(s,...)
	localns

	ns=s:format(...).."\n"

	Msg(ns)
	ServerLog(ns)

	ifs:match("error")then
		ErrorNoHalt(ns)
	end
end

function_R.Player:Save()
	EasyLog("%q(%s)hadtheirxpsaved.",self:Nick(),self:UniqueID())
	self:SetPData("xp"	,self.XPorDEFAULT_XP	)
	self:SetPData("lvl"	,self.LevelorDEFAULT_LEVEL	)
end

function_R.Player:Load()
	EasyLog("%q(%s)hadtheirxploaded.",self:Nick(),self:UniqueID())
	self.XP	=self:GetPData("xp"	,DEFAULT_XP	)
	self.Level	=self:GetPData("lvl"	,DEFAULT_LEVEL)
end

function_R.Player:GetXP()
	returnself.XP
end

function_R.Player:AddXP(n)
	self.XP=self.XP+n
end

function_R.Player:GetNeededXP()
	returnself.Level*EXPERIENCE_SCALE
end

localfunctionSWPrintLevel(pl)
	pl:ChatPrint("Yourlevelisnow:"..pl.LevelorDEFAULT_LEVEL)
end

--NEVERCALLTHISFUNCTIONFROMTHETOPWITHAVALIDARGUMENT
--Doingsowillnotallowittosavetheplayer'sdata
function_R.Player:Levelup(recur)
	ifself.XP>=self:GetNeededXP()then
		self.XP=self.XP-self:GetNeededXP()
		self.Level=self.Level+1
		self:Levelup(true)

		ifnotrecurthen
			self:Save()
			timer.Simple(.1,PrintLevel,self)
		end
	end
end

localfunctionAutoSave()
	localk,v

	fork,vinipairs(player.GetAll())do
		v:Save()
	end
end

localfunctionSWOnNPCKilled(victim,killer)//note:GM:OnNPCKilled()isarealfunctionfromGMOD!!
	ifValidEntity(killer)andkiller:IsPlayer()then
		killer:AddXP(REWARD_XP)
		killer:Levelup()
	end
end

localfunctionSWPlayerDeath(victim,killer)
ifValidEntity(killer)andkiller:IsPlayer()then
killer:AddXP(REWARD_XP)
killer:Levelup()
end
end

hook.Add("PlayerInitialSpawn"	,"Level.InitSpawn",_R.Player.Load	)
hook.Add("PlayerDisconnected"	,"Level.PlDiscnct",_R.Player.Save	)
hook.Add("OnNPCKilled"		,"Level.NPCKilled",OnNPCKilled	)
hook.Add("PlayerDeath","Level.PlayerDeath",playerDies)
timer.Create("SaveXP",600,0,AutoSave)

functionplayerRespawn(ply)
	
	localPlayerHP=100+(ply.Level*2)
	ply:SetMaxHealth(PlayerHP)
	ply:SetHealth(PlayerHP)
	ply:SetArmor(100+(ply.Level*2))
	localPlayerSpeed=200+(ply.Level*5)
	ply:SetWalkSpeed(PlayerSpeed)
	ply:SetRunSpeed(PlayerSpeed*2)
end

hook.Add("PlayerSpawn","SetPlayerStats",playerRespawn)

functionPlayerDamage(ply,hitgroup,dmginfo)
	localAttacker=dmginfo:GetAttacker()
	ifAttacker:IsNPC()then
		dmginfo:ScaleDamage(1+(Attacker.Level/2))
	end
end

hook.Add("ScaleNPCDamage","NPCDamageHook",NPCDamage)

functionEasyLog(s,...)
	localns

	ns=s:format(...).."\n"

	Msg(ns)
	ServerLog(ns)

	ifs:match("error")then
		ErrorNoHalt(ns)
	end
end

function_R.Player:Save()
	EasyLog("%q(%s)hadtheirrifxpsaved.",self:Nick(),self:UniqueID())
	self:SetPData("rifxp"	,self.RifxporDEFAULT_RIF	)
	self:SetPData("riflvl"	,self.RiflevelorDEFAULT_RIFLVL	)
end

function_R.Player:Load()
	EasyLog("%q(%s)hadtheirrifxploaded.",self:Nick(),self:UniqueID())
	self.XP	=self:GetPData("rifxp"	,DEFAULT_RIF	)
	self.Level	=self:GetPData("riflvl"	,DEFAULT_RIFLVL)
end

function_R.Player:GetRifXP()
	returnself.RifXP
end

function_R.Player:AddRifXP(n)
	self.RifXP=self.RifXP+n
end

function_R.Player:GetNeededRifXP()
	returnself.RifLevel*EXPERIENCE_RIFSCALE
end

localfunctionPrintRifLevel(pl)
	pl:ChatPrint("YourRiflelevelisnow:"..pl.RifLevelorDEFAULT_RIFLEVEL)
end

--NEVERCALLTHISFUNCTIONFROMTHETOPWITHAVALIDARGUMENT
--Doingsowillnotallowittosavetheplayer'sdata
function_R.Player:RifLevelup(recur)
	ifself.RifXP>=self:GetNeededRifXP()then
		self.RifXP=self.RifXP-self:GetNeededRifXP()
		self.RifLevel=self.RifLevel+1
		self:RifLevelup(true)

		ifnotrecurthen
			self:Save()
			timer.Simple(.1,PrintRifLevel,self)
		end
	end
end

localfunctionAutoSave()
	localk,v

	fork,vinipairs(player.GetAll())do
		v:Save()
	end
end

localfunctionSWOnNPCKilled(victim,killer,weapon)
	ifValidEntity(killer)andkiller:IsPlayer()andweapon:GetClass()==("smg1")then
		killer:AddRifXP(REWARD_RIFXP)
		killer:RifLevelup()
	end
end

localfunctionSWPlayerDeath(victim,killer,weapon)
ifValidEntity(killer)andkiller:IsPlayer()andweapon:GetClass()==("smg1")then
killer:AddRifXP(REWARD_RIFXP)
killer:RifLevelup()
end
end

hook.Add("PlayerInitialSpawn"	,"Level.InitSpawn",_R.Player.Load	)
hook.Add("PlayerDisconnected"	,"Level.PlDiscnct",_R.Player.Save	)
hook.Add("OnNPCKilled"		,"Level.NPCKilled",OnNPCKilled	)
hook.Add("PlayerDeath","Level.PlayerDeath",playerDies)
timer.Create("SaveXP",600,0,AutoSave)



functionSWNPCDamage(npc,hitgroup,dmginfo)
	localAttacker=dmginfo:GetAttacker()
	ifAttacker:IsPlayer()then
		dmginfo:ScaleDamage(1+(Attacker.Level/2))
	end
end

hook.Add("ScaleNPCDamage","NPCDamageHook",NPCDamage)

functionMaxlevel(ply)
	ifself:GetPData("lvl")>=75then
		self:SetPData("lvl",75)
	end
end

functionGM:SWPlayerSaid(ply,saywhat)
	localplayerName=ply:GetName()
	ifstring.find(saywhat,"!info")==1then
	localInfoTable=GM:SWReadPlayerData()
		forkey,valueinpairs(InfoTable)do
			ply:PrintMessage(HUD_PRINTTALK,key..":"..value.."\n")
		end
	end
end

hook.Add("PlayerSay","playerSaid",playerSaid)

functionEasyLog(s,...)
	localns

	ns=s:format(...).."\n"

	Msg(ns)
	ServerLog(ns)

	ifs:match("error")then
		ErrorNoHalt(ns)
	end
end

function_R.Player:Save()
	EasyLog("%q(%s)hadtheirPistolxpsaved.",self:Nick(),self:UniqueID())
	self:SetPData("pxp"	,self.pxporDEFAULT_PIS	)
	self:SetPData("pislvl"	,self.PislevelorDEFAULT_PISLVL	)
end

function_R.Player:Load()
	EasyLog("%q(%s)hadtheirPistolxploaded.",self:Nick(),self:UniqueID())
	self.XP	=self:GetPData("pxp"	,DEFAULT_PIS	)
	self.Level	=self:GetPData("pislvl"	,DEFAULT_PISLVL)
end

function_R.Player:GetPXP()
	returnself.PXP
end

function_R.Player:AddPXP(n)
	self.PXP=self.PXP+n
end

function_R.Player:GetNeededPXP()
	returnself.PisLevel*EXPERIENCE_PISSCALE
end

localfunctionPrintPisLevel(pl)
	pl:ChatPrint("YourPistollevelisnow:"..pl.PisLevelorDEFAULT_PISLEVEL)
end

--NEVERCALLTHISFUNCTIONFROMTHETOPWITHAVALIDARGUMENT
--Doingsowillnotallowittosavetheplayer'sdata
function_R.Player:PisLevelup(recur)
	ifself.PXP>=self:GetNeededPXP()then
		self.PXP=self.PXP-self:GetNeededPXP()
		self.PisLevel=self.PisLevel+1
		self:PisLevelup(true)

		ifnotrecurthen
			self:Save()
			timer.Simple(.1,PrintPisLevel,self)
		end
	end
end

localfunctionAutoSave()
	localk,v

	fork,vinipairs(player.GetAll())do
		v:Save()
	end
end

localfunctionSWOnNPCKilled(victim,killer,weapon)
	ifValidEntity(killer)andkiller:IsPlayer()andweapon:GetClass()==("pistol")then
		killer:AddPXP(REWARD_PXP)
		killer:PisLevelup()
	end
end

localfunctionSWPlayerDeath(victim,killer,weapon)
ifValidEntity(killer)andkiller:IsPlayer()andweapon:GetClass()==("pistol")then
killer:AddRifXP(REWARD_RIFXP)
killer:RifLevelup()
end
end

hook.Add("PlayerInitialSpawn"	,"Level.InitSpawn",_R.Player.Load	)
hook.Add("PlayerDisconnected"	,"Level.PlDiscnct",_R.Player.Save	)
hook.Add("OnNPCKilled"		,"Level.NPCKilled",OnNPCKilled	)
hook.Add("PlayerDeath","Level.PlayerDeath",playerDies)
timer.Create("SaveXP",600,0,AutoSave)



functionGM:SWNPCDamage(npc,hitgroup,dmginfo)
	localAttacker=dmginfo:GetAttacker()
	ifAttacker:IsPlayer()then
		dmginfo:ScaleDamage(1+(Attacker.Level/2))
	end
end

hook.Add("ScaleNPCDamage","NPCDamageHook",NPCDamage)

functionLevelSound(ply)
ifply.Levelup==(true)then
self.EmitSound("StarWarsSoundtrack-Luke'sTheme.mp3")
end
end




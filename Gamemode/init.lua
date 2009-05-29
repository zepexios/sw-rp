AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_weather.lua")

include('shared.lua')
include('missions.lua')

DataTable= SWReadPlayerData(ply)		//callinganilvaluefinishloginerrorsshoulddisappearbythen					//definestheplayerdatatable,lotsoffunctionsneedtoaccessthis!


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

function GM:PlayerInitialSpawn(ply)	//iftheyhavenoteam(firsttimeonserver)setthemtociv
	if(ply:Team()<1)thenply:SetTeam(1)
	
	SWPlayerData(ply,ReadTable,table,Main)
	end	
end


localFName="Test"
functionSWPlayerData(ToDo,table,FileName)
	if(ToDO=="WirteTable")then
		localSaveTable=
	end

	if(ToDo=="ReadTable")then
		if(file.Exists("UserData/Data.txt"))then
		localReadTable=file.Read("UserData/Data.txt")
		table=util.KeyValuesToTable(ReadTable)
		end
	returnLoadTab
	end
end
functionSWGetData(Type)
	if(Type=="Name")then
	return"MGinshe"
	elseif(Type=="Money")then
	return10000
	elseif(Type=="Team")then
	return"Merc's"
	elseif(Type=="Class")then
	return"Jedi"
	elseif(Type=="CombatLvl")then
	return74
	elseif(Type=="CombatXP")then
	returnSWGetData("CombatLvl")/2/2/2*(SWGetData("CombatLvl")*100)
	elseif(Type=="TCombatXP")then
	return-1
	elseif(Type=="RifleLvl")then
	return76
	elseif(Type=="RifleXP")then
	returnSWGetData("RifleLvl")/2/2/2*(SWGetData("RifleLvl")*100)
	elseif(Type=="TRifleXP")then
	return-1
	elseif(Type=="SaberLvl")then
	return75
	elseif(Type=="SaberXP")then
	returnSWGetData("SaberLvl")/2/2/2*(SWGetData("SaberLvl")*100)
	elseif(Type=="TSaberXP")then
	return10000
	else
	return"Undefined"
	end
end
DataTable={
	Name=SWGetData("Name"),
	Money=SWGetData("Money"),
	Team=SWGetData("Team"),
	Class=SWGetData("Class"),
	CombatLvl=SWGetData("CombatLvl"),
	CombatXP=SWGetData("ComabtXP"),
	TotalCombatXP=SWGetData("TCombatXP"),
	RifleLvl=SWGetData("RifleLvl"),
	RifleXP=SWGetData("RifleXP"),
	TotalRifleXP=SWGetData("TRifleXP"),
	SaberLvl=SWGetData("SaberLvl"),
	SaberXP=SWGetData("aberXP"),
	TotalSaberXP=SWGetData("TSaberXP"),
	}
fork,vinpairs(DataTable)do
	print(k..":"..v)
end






functionGM:PlayerSpawn(ply)





self.BaseClass:PlayerSpawn(ply)

ply:SetGravity(0.75)
ply:SetMaxHealth(100,true)

ply:SetWalkSpeed(250)
ply:SetRunSpeed(400)

//ply:SetTeam(1)//Team1isgueststhedefaultjoiningteam
//NOTE!:thatwouldhavesetthemtoteam1everytimetheyspawned...
//FIX:putthatinGM:PlayerInitialSpawn()withanifstatment

end

//testfunction,thatwilllvlallskillsup:)
functionSWXPSystem(player,XPAmount,Type,TType)
	ID=player:UniqueID()
	NewXP=DataTable.TypeXP+XPAmount	
	DataTable.
	if(NewXP>=(DataTable.TypeLvl*100))then
		LvlUp=true
		NewRifleLvl=DataTable.ID.XP.TypeLvl+1
		player:PrintMessage(HUD_PRINTTALK,"[SW-RP]Youleveldyour"..Type.."skillup!It'snowLvl"..NewRifleLvl.."!")
	end
	SWSetPlayerData(player)
	SWReadPlayerData(player)
	LvlUp=false
	if(TType==TotalXP)then
		localTotalTypeXP=DataTable.TypeXP+DataTable.TotalTypeXP
		returnDataTabe.TotalTypeXP
	end
	if(TType==XP)then
		returnDataTabe.TypeXP
	end
	if(TType==Lvl)then
		if(RifleLvlUp)then
			returnNewRifleLvl
		else
		returnDataTable.RifleLvl
	end
	end
end


functionSWGetRifleLvl()
	if(RifleLvlUp)then
		returnNewRifleLvl
	else
	returnDataTable.RifleLvl
	end
end
functionSWGetRifleXP()
	returnNewRifleXP
end
functionSWGetTotalRifleXP()
	localTotalRifleXP=DataTable.RifleXP+DataTable.TotalRifleXP
	returnTotalRifleXP
end

functionGM:OnNPCKilled(victim,killer,weapon)
fork,vinpairs(DataTable.RifleXP+DataTable.XP)do
end
end



concommand.Add("AddXp",SWSetRifleXP(ply,100))

functionGM:PlayerLoadout(ply)
	player=ply
	ifply:Team()==(2)then
		ply:Give("weapon_mp5")//Willspawnwithhandswhenimplemented
		ply:Spawn()
	end
end

//functionGM:PlayerConnect(UniqueID)
//ply:SetNetworkedString("UniqueID",ply:UniqueID)
//end



functionGM:SWProfessions(ply)
ifply:Team()==2thenRifLvl=math.Clamp(RifLvl,0,50)end
end




function_R.Player:Bleed()
ifValidEntity(self)andself.Bleedingandself:Alive()then
self:TakeDamage(5)
timer.Simple(3,self.Bleed,self)
end
end

localfunctionBandage(pl)
ifnotpl:Alive()then
return
end

ifnotpl.Bleedingthen
pl:ChatPrint("Youarenotbleeding")
return
end

ifpl.Bandages>0then
pl:ChatPrint("Youstoppedyourbleedingwithabandage")
pl.Bleeding=false
pl.Bandages=pl.Bandages-1
else
pl:ChatPrint("Youdonothaveanybandages")
return
end
end

localfunctionPlayerSpawn(pl)
pl.Bleeding=false
pl.Bandages=MAX_BANDAGES
end

hook.Add("PlayerSpawn","Bleeding.Reset",PlayerSpawn)
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




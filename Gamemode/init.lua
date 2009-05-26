AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_weather.lua" )

 include( 'shared.lua' )
 include( 'missions.lua' )
 include( 'login.lua' )
/*********************NOTE!*******************************************************************
 // try and prefix all functions with "GM:" , and satrt the function name with "SW"
 // makes it easyer for us all to read/understand, i will change this, then place it in another folder for now ; )
 // MGinshe
 ***********************************************************************************************/
 
//Desc: Variable Set Up here
//Reason: you can see at a glance what variables are what, and change them without having to go through LOTS of code.


DataTable = SWReadPlayerData( ply )		//calling a nil value finish login errors should disappear by then					//defines the player data table, lots of functions need to access this!

 
 MAX_BANDAGES			= 5 	--How many bandages the player has and is set to this number on (re)spawn
 DEFAULT_XP 			= 0		--Amount of XP player first starts playing SW-RP with
 DEFAULT_LEVEL 			= 1		--The Level the player start SW-RP on
 EXPERIENCE_SCALE 		= 800	--How much each level costs in XP, times level
 REWARD_XP				= 25	--How much XP is rewarded for a kill
 DEFAULT_RIF 			= 0		--i THINK this is the starting rifle level/xp
 DEFAULT_RIFLVL			= 0		--i THINK this is the starting rifle level/xp
 EXPERIENCE_RIFSCALE 	= 500	--How much each level costs in XP, times level
 REWARD_RXP				= 50	--How much XP is rewarded for a kill
 DEFAULT_PIS			= 0		--starting pistol xp
 DEFAULT_PISLVL			= 0		-- starting pistol level
 EXPERIENCE_PISSSCALE 	= 500	--How much each level costs in XP, times level
 REWARD_PXP				= 50	--How much XP is rewarded for a kill
 
 function GM:PlayerInitialSpawn( ply ) 	//if they have no team (first time on server) set them to civ
	ply = Ply 							//dosent make sense? dw...//my futile attampt at mkiang "ply" global D: ..MGinshe.. :D
	if(ply:Team() < 1) then ply:SetTeam(1)
	
	end	
end
 
 
 function GM:PlayerSpawn( ply )
 
 self.BaseClass:PlayerSpawn( ply )
 
 ply:SetGravity( 0.75 )
 ply:SetMaxHealth( 100, true )
 
 ply:SetWalkSpeed( 250 )
 ply:SetRunSpeed( 400 )
 
 //ply:SetTeam( 1 ) // Team 1 is guests the default joining team 
 //NOTE!: that would have set them to team 1 every time they spawned...
 //FIX: put that in GM:PlayerInitialSpawn()  with an if statment
 
 end
 
function SWSetRifleXP( player, XPAmount )
	NewRifleXP = DataTable.RifleXP + XPAmount	
	if(NewRifleXP >= (DataTable.RifleLvl * 100)) then
		RifleLvlUp = true
		NewRifleLvl = DataTable.RifleLvl + 1
		ply:PrintMessage(HUD_PRINTTALK, "[SW-RP] You leveld your Rifle skill up! It's now Lvl " ..NewRifleLvl.." !")
	end
	SWSetPlayerData( player )
	RifleLvlUp = false
end
function SWGetRifleLvl()
	if(RifleLvlUp) then
		return NewRifleLvl
	else 
	return DataTable.RifleLvl
	end
end
function SWGetRifleXP()
	return NewRifleXP
end
function SWGetTotalRifleXP()
	local TotalRifleXP = DataTable.RifleXP + DataTable.TotalRifleXP
	return TotalRifleXP
end


//test function, that will lvl all skills up :)
function SWSetXP( player, XPAmount, Type )
	ID = player:UniqueID()
	NewXP = DataTable.ID.XP.TypeXP + XPAmount	
	if(NewXP >= (DataTable.ID.XP.TypeLvl * 100)) then
		LvlUp = true
		NewRifleLvl = DataTable.ID.XP.TypeLvl + 1
		player:PrintMessage(HUD_PRINTTALK, "[SW-RP] You leveld your "..Type.." skill up! It's now Lvl " ..NewRifleLvl.." !")
	end
	SWSetPlayerData( player )
	SWReadPlayerData( player )
	LvlUp = false
end
function SWGetRifleLvl()
	if(RifleLvlUp) then
		return NewRifleLvl
	else 
	return DataTable.RifleLvl
	end
end
function SWGetRifleXP()
	return NewRifleXP
end
function SWGetTotalRifleXP()
	local TotalRifleXP = DataTable.RifleXP + DataTable.TotalRifleXP
	return TotalRifleXP
end

function GM:OnNPCKilled( victim, killer, weapon )
   for k,v in pairs(DataTable.RifleXP + DataTable.XP) do
end
end



concommand.Add( "AddXp", SWSetRifleXP( ply, 100 ))

 function GM:PlayerLoadout( ply )
	player = ply
	if ply:Team() == (2) then
		ply:Give( "weapon_mp5" ) // Will spawn with hands when implemented
		ply:Spawn()
	end 
 end
 
 //function GM:PlayerConnect( UniqueID ) 
 //ply:SetNetworkedString("UniqueID", ply:UniqueID)
 //end 
 
 
 
 function GM:SWProfessions( ply )
      if ply:Team( ) == 2 then RifLvl = math.Clamp( RifLvl, 0, 50 ) end
end




function _R.Player:Bleed( )
  if ValidEntity( self ) and self.Bleeding and self:Alive( ) then
    self:TakeDamage( 5 )
    timer.Simple( 3, self.Bleed, self )
  end
end

local function Bandage( pl )
  if not pl:Alive( ) then
   return
  end

  if not pl.Bleeding then
    pl:ChatPrint( "You are not bleeding" )
    return
  end

  if pl.Bandages > 0 then
    pl:ChatPrint( "You stopped your bleeding with a bandage" )
    pl.Bleeding = false
    pl.Bandages = pl.Bandages - 1
  else
    pl:ChatPrint( "You do not have any bandages" )
    return
  end
end

local function PlayerSpawn( pl )
  pl.Bleeding = false
  pl.Bandages = MAX_BANDAGES
end

hook.Add( "PlayerSpawn", "Bleeding.Reset", PlayerSpawn )
concommand.Add( "/bandage", Bandage )

if damage_info:IsBulletDamage( ) then
  if not pl.Bleeding then
    pl.Bleeding = true
    timer.Simple( 3, pl.Bleed, pl )
  end
end

function EasyLog( s, ... )
	local ns

	ns = s:format( ... ) .. "\n"

	Msg( ns )
	ServerLog( ns )

	if s:match( "error" ) then
		ErrorNoHalt( ns )
	end
end

function _R.Player:Save( )
	EasyLog( "%q (%s) had their xp saved.", self:Nick( ), self:UniqueID( ) )
	self:SetPData( "xp"	, self.XP or DEFAULT_XP 	)
	self:SetPData( "lvl"	, self.Level or DEFAULT_LEVEL 	)
end

function _R.Player:Load( )
	EasyLog( "%q (%s) had their xp loaded.", self:Nick( ), self:UniqueID( ) )
	self.XP 	= self:GetPData( "xp"	, DEFAULT_XP 	)
	self.Level 	= self:GetPData( "lvl"	, DEFAULT_LEVEL )
end

function _R.Player:GetXP( )
	return self.XP
end

function _R.Player:AddXP( n )
	self.XP = self.XP + n
end

function _R.Player:GetNeededXP( )
	return self.Level * EXPERIENCE_SCALE
end

local function SWPrintLevel( pl )
	pl:ChatPrint( "Your level is now: " .. pl.Level or DEFAULT_LEVEL )
end

--NEVER CALL THIS FUNCTION FROM THE TOP WITH A VALID ARGUMENT
--Doing so will not allow it to save the player's data
function _R.Player:Levelup( recur )
	if self.XP >= self:GetNeededXP( ) then
		self.XP = self.XP - self:GetNeededXP( )
		self.Level = self.Level + 1
		self:Levelup( true )

		if not recur then
			self:Save( )
			timer.Simple( .1, PrintLevel, self )
		end
	end
end

local function AutoSave( )
	local k, v

	for k, v in ipairs( player.GetAll( ) ) do
		v:Save( )
	end
end

local function SWOnNPCKilled( victim, killer ) //note: GM:OnNPCKilled() is a real function from GMOD!!
	if ValidEntity( killer ) and killer:IsPlayer( ) then
		killer:AddXP( REWARD_XP )
		killer:Levelup( )
	end
end

local function SWPlayerDeath( victim, killer )
      if ValidEntity( killer ) and killer:IsPlayer( ) then
             killer:AddXP( REWARD_XP )
             killer:Levelup( )
end
end

hook.Add( "PlayerInitialSpawn"	, "Level.InitSpawn", _R.Player.Load 	)
hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", playerDies )
timer.Create( "SaveXP", 600, 0, AutoSave )

function playerRespawn( ply )
	
	local PlayerHP = 100 + ( ply.Level * 2 )
	ply:SetMaxHealth( PlayerHP )
	ply:SetHealth( PlayerHP )
	ply:SetArmor( 100 + ( ply.Level * 2) )
	local PlayerSpeed = 200 + (ply.Level * 5)
	ply:SetWalkSpeed( PlayerSpeed ) 
	ply:SetRunSpeed( PlayerSpeed * 2 ) 
end

hook.Add( "PlayerSpawn", "SetPlayerStats", playerRespawn ) 

function PlayerDamage( ply, hitgroup, dmginfo )
	local Attacker = dmginfo:GetAttacker()
	if Attacker:IsNPC() then
		dmginfo:ScaleDamage( 1 + (Attacker.Level / 2)) 
	end
end

hook.Add( "ScaleNPCDamage", "NPCDamageHook", NPCDamage ) 

function EasyLog( s, ... )
	local ns

	ns = s:format( ... ) .. "\n"

	Msg( ns )
	ServerLog( ns )

	if s:match( "error" ) then
		ErrorNoHalt( ns )
	end
end

function _R.Player:Save( )
	EasyLog( "%q (%s) had their rifxp saved.", self:Nick( ), self:UniqueID( ) )
	self:SetPData( "rifxp"	, self.Rifxp or DEFAULT_RIF 	)
	self:SetPData( "riflvl"	, self.Riflevel or DEFAULT_RIFLVL 	)
end

function _R.Player:Load( )
	EasyLog( "%q (%s) had their rifxp loaded.", self:Nick( ), self:UniqueID( ) )
	self.XP 	= self:GetPData( "rifxp"	, DEFAULT_RIF 	)
	self.Level 	= self:GetPData( "riflvl"	, DEFAULT_RIFLVL )
end

function _R.Player:GetRifXP( )
	return self.RifXP
end

function _R.Player:AddRifXP( n )
	self.RifXP = self.RifXP + n
end

function _R.Player:GetNeededRifXP( )
	return self.RifLevel * EXPERIENCE_RIFSCALE
end

local function PrintRifLevel( pl )
	pl:ChatPrint( "Your Rifle level is now: " .. pl.RifLevel or DEFAULT_RIFLEVEL )
end

--NEVER CALL THIS FUNCTION FROM THE TOP WITH A VALID ARGUMENT
--Doing so will not allow it to save the player's data
function _R.Player:RifLevelup( recur )
	if self.RifXP >= self:GetNeededRifXP( ) then
		self.RifXP = self.RifXP - self:GetNeededRifXP( )
		self.RifLevel = self.RifLevel + 1
		self:RifLevelup( true )

		if not recur then
			self:Save( )
			timer.Simple( .1, PrintRifLevel, self )
		end
	end
end

local function AutoSave( )
	local k, v

	for k, v in ipairs( player.GetAll( ) ) do
		v:Save( )
	end
end

local function SWOnNPCKilled( victim, killer, weapon )
	if ValidEntity( killer ) and killer:IsPlayer( ) and weapon:GetClass() == ("smg1") then
		killer:AddRifXP( REWARD_RIFXP )
		killer:RifLevelup( )
	end
end

local function SWPlayerDeath( victim, killer, weapon )
      if ValidEntity( killer ) and killer:IsPlayer( ) and weapon:GetClass() == ("smg1") then
             killer:AddRifXP( REWARD_RIFXP )
             killer:RifLevelup( )
end
end

hook.Add( "PlayerInitialSpawn"	, "Level.InitSpawn", _R.Player.Load 	)
hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", playerDies )
timer.Create( "SaveXP", 600, 0, AutoSave )



function SWNPCDamage( npc, hitgroup, dmginfo )
	local Attacker = dmginfo:GetAttacker()
	if Attacker:IsPlayer() then
		dmginfo:ScaleDamage( 1 + (Attacker.Level / 2)) 
	end
end

hook.Add( "ScaleNPCDamage", "NPCDamageHook", NPCDamage ) 

function Maxlevel( ply )
	if self:GetPData( "lvl" ) >= 75 then
		self:SetPData( "lvl", 75 )
	end
end

function GM:SWPlayerSaid( ply, saywhat )
	local playerName = ply:GetName()
	if string.find(saywhat, "!info") == 1 then
	local InfoTable = GM:SWReadPlayerData()
		for key,value in pairs(InfoTable) do
			ply:PrintMessage(HUD_PRINTTALK, key..": "..value.."\n")
		end
	end
end
 
hook.Add ( "PlayerSay", "playerSaid", playerSaid )

function EasyLog( s, ... )
	local ns

	ns = s:format( ... ) .. "\n"

	Msg( ns )
	ServerLog( ns )

	if s:match( "error" ) then
		ErrorNoHalt( ns )
	end
end

function _R.Player:Save( )
	EasyLog( "%q (%s) had their Pistol xp saved.", self:Nick( ), self:UniqueID( ) )
	self:SetPData( "pxp"	, self.pxp or DEFAULT_PIS 	)
	self:SetPData( "pislvl"	, self.Pislevel or DEFAULT_PISLVL 	)
end

function _R.Player:Load( )
	EasyLog( "%q (%s) had their Pistol xp loaded.", self:Nick( ), self:UniqueID( ) )
	self.XP 	= self:GetPData( "pxp"	, DEFAULT_PIS 	)
	self.Level 	= self:GetPData( "pislvl"	, DEFAULT_PISLVL )
end

function _R.Player:GetPXP( )
	return self.PXP
end

function _R.Player:AddPXP( n )
	self.PXP = self.PXP + n
end

function _R.Player:GetNeededPXP( )
	return self.PisLevel * EXPERIENCE_PISSCALE
end

local function PrintPisLevel( pl )
	pl:ChatPrint( "Your Pistol level is now: " .. pl.PisLevel or DEFAULT_PISLEVEL )
end

--NEVER CALL THIS FUNCTION FROM THE TOP WITH A VALID ARGUMENT
--Doing so will not allow it to save the player's data
function _R.Player:PisLevelup( recur )
	if self.PXP >= self:GetNeededPXP( ) then
		self.PXP = self.PXP - self:GetNeededPXP( )
		self.PisLevel = self.PisLevel + 1
		self:PisLevelup( true )

		if not recur then
			self:Save( )
			timer.Simple( .1, PrintPisLevel, self )
		end
	end
end

local function AutoSave( )
	local k, v

	for k, v in ipairs( player.GetAll( ) ) do
		v:Save( )
	end
end

local function SWOnNPCKilled( victim, killer, weapon )
	if ValidEntity( killer ) and killer:IsPlayer( ) and weapon:GetClass() == ("pistol") then
		killer:AddPXP( REWARD_PXP )
		killer:PisLevelup( )
	end
end

local function SWPlayerDeath( victim, killer, weapon )
      if ValidEntity( killer ) and killer:IsPlayer( ) and weapon:GetClass() == ("pistol") then
             killer:AddRifXP( REWARD_RIFXP )
             killer:RifLevelup( )
end
end

hook.Add( "PlayerInitialSpawn"	, "Level.InitSpawn", _R.Player.Load 	)
hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", playerDies )
timer.Create( "SaveXP", 600, 0, AutoSave )



function GM:SWNPCDamage( npc, hitgroup, dmginfo )
	local Attacker = dmginfo:GetAttacker()
	if Attacker:IsPlayer() then
		dmginfo:ScaleDamage( 1 + (Attacker.Level / 2)) 
	end
end

hook.Add( "ScaleNPCDamage", "NPCDamageHook", NPCDamage ) 




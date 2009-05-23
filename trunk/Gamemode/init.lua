AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_weather.lua" )

 include( 'shared.lua' )
 include( 'missions.lua' )
 
 function GM:PlayerSpawn( ply )
 
 self.BaseClass:PlayerSpawn( ply )
 
 ply:SetGravity( 0.75 )
 ply:SetMaxHealth( 100, true )
 
 ply:SetWalkSpeed( 250 )
 ply:SetRunSpeed( 400 )
 
 ply:SetTeam( 1 ) // Team 1 is guests the default joining team
 
 end
 
 function GM:PlayerLoadout( ply )
 if ply:Team() == (2) then
 ply:Give( "weapon_mp5" ) // Will spawn with hands when implemented
 ply:Spawn()
 end 
 end
 
 function professions( ply )
 if (Team == "2" and RifLvl > 50) then (RifLvl = 50 ) 
 end
 end
 end
 
 MAX_BANDAGES = 5 --How many bandages the player has and is set to this number on (re)spawn

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

DEFAULT_XP 		= 0
DEFAULT_LEVEL 		= 1
EXPERIENCE_SCALE 	= 800	--How much each level costs in XP, times level
REWARD_XP		= 25	--How much XP is rewarded for a kill

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

local function PrintLevel( pl )
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

local function OnNPCKilled( victim, killer )
	if ValidEntity( killer ) and killer:IsPlayer( ) then
		killer:AddXP( REWARD_XP )
		killer:Levelup( )
	end

local function PlayerDeath( victim, killer )
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

DEFAULT_RIF 		= 0
DEFAULT_RIFLVL		= 0
EXPERIENCE_RIFSCALE 	= 500	--How much each level costs in XP, times level
REWARD_RXP		= 50	--How much XP is rewarded for a kill

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
	pl:ChatPrint( "Your Riflelevel is now: " .. pl.RifLevel or DEFAULT_RIFLEVEL )
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

local function OnNPCKilled( victim, killer )
	if ValidEntity( killer ) and killer:IsPlayer( ) then
		killer:AddRifXP( REWARD_RIFXP )
		killer:RifLevelup( )
	end

local function PlayerDeath( victim, killer )
      if ValidEntity( killer ) and killer:IsPlayer( ) then
             killer:AddRifXP( REWARD_RIFXP )
             killer:RifLevelup( )
end
end

hook.Add( "PlayerInitialSpawn"	, "Level.InitSpawn", _R.Player.Load 	)
hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", playerDies )
timer.Create( "SaveXP", 600, 0, AutoSave )



function NPCDamage( npc, hitgroup, dmginfo )
	local Attacker = dmginfo:GetAttacker()
	if Attacker:IsPlayer() then
		dmginfo:ScaleDamage( 1 + (Attacker.Level / 2)) 
	end
end

hook.Add( "ScaleNPCDamage", "NPCDamageHook", NPCDamage ) 

function Maxlevel( ply )
if self:SetPData( "lvl" >= 75 then "lvl" = 75 )
end
end


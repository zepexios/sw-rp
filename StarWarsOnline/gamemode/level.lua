DEFAULT_XP 		= 0
DEFAULT_LEVEL 		= 1
EXPERIENCE_SCALE 	= 100	--How much each level costs in XP, times level
REWARD_XP		= 10	--How much XP is rewarded for a kill

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
	
	local PlayerHP = 100 + ( ply.Level * 15 )
	ply:SetMaxHealth( PlayerHP )
	ply:SetHealth( PlayerHP )
	local PlayerSpeed = 200 + (ply.Level * 5)
	ply:SetWalkSpeed( PlayerSpeed ) 
	ply:SetRunSpeed( PlayerSpeed * 2 ) 
end

hook.Add( "PlayerSpawn", "SetPlayerStats", playerRespawn ) 

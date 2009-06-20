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
	self:ChatPrint("Account Saved")
	EasyLog( "%q (%s) had their xp saved.", self:Nick( ), self:UniqueID( ) )
	self:SaveChars()
end

function _R.Player:GetXP( )
	return self.xp
end

function _R.Player:AddXP( n )
	if !self.CurrentChar.xp then self.CurrentChar.xp = DEFAULT_XP end
	if !self.CurrentChar.level then self.CurrentChar.level = DEFAULT_LEVEL end
	self.CurrentChar.xp = self.CurrentChar.xp + n
end

function _R.Player:GetNeededXP( )
	return self.CurrentChar.level * EXPERIENCE_SCALE
end

function PrintLevel( pl )
	pl:ChatPrint( "Your level is now: " .. pl.CurrentChar.level or DEFAULT_LEVEL )
end

function LevelSound( pl )
pl:EmitSound( "luke.mp3" )
LevelUpEffect(pl:GetPos())
end

--NEVER CALL THIS FUNCTION FROM THE TOP WITH A VALID ARGUMENT
--Doing so will not allow it to save the player's data
function _R.Player:Levelup( recur )
	if self.CurrentChar.xp >= self:GetNeededXP( ) then
		self.CurrentChar.xp = self.CurrentChar.xp - self:GetNeededXP( )
		self.CurrentChar.level = self.CurrentChar.level + 1
		PrintLevel(self)
		LevelSound(self)
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
end

local function PlayerDeath( victim, killer )
      if ValidEntity( killer ) and killer:IsPlayer( ) then
             killer:AddXP( REWARD_XP )
             killer:Levelup( )
end
end

hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", playerDies )
timer.Create( "SaveXP", 120, 0, AutoSave )

function playerRespawn( ply )
	if !ply.CurrentChar then return end
	local PlayerHP = 100 + ( ply.CurrentChar.Level * 15 )
	ply:SetMaxHealth( PlayerHP )
	ply:SetHealth( PlayerHP )
	local PlayerSpeed = 200 + (ply.CurrentChar.Level * 5)
	ply:SetWalkSpeed( PlayerSpeed ) 
	ply:SetRunSpeed( PlayerSpeed * 2 ) 
end

hook.Add( "PlayerSpawn", "SetPlayerStats", playerRespawn ) 

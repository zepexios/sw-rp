DEFAULT_XP 			= 0
DEFAULT_LEVEL 		= 1
EXPERIENCE_SCALE 	= 100	--How much each level costs in XP, times level
REWARD_XP			= 10	--How much XP is rewarded for a kill

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
	return self.Char.xp
end

function _R.Player:AddXP( n )
	if !self.Char.xp then self.Char.xp = DEFAULT_XP end
	if !self.Char.level then self.Char.level = DEFAULT_LEVEL end
	self.Char.xp = self.Char.xp + n
	self:SetNWString("xp", self.Char.xp)
end

function _R.Player:GetNeededXP( )
	return self.Char.level * EXPERIENCE_SCALE or 100
end

function _R.Player:GetLevel()
	return self.Char.level
end

function PrintLevel( pl )
	pl:ChatPrint( "Your level is now: " .. pl.Char.level or DEFAULT_LEVEL )
end

function LevelSound( pl )
pl:EmitSound( "SWO/client/luke.mp3" ) --@meeces2911 Updated sound path
LevelUpEffect(pl:GetPos())
end

--NEVER CALL THIS FUNCTION FROM THE TOP WITH A VALID ARGUMENT
--Doing so will not allow it to save the player's data
function _R.Player:Levelup( recur )
	if self.Char.xp >= self:GetNeededXP( ) then
		self.Char.xp = self.Char.xp - self:GetNeededXP( )
		self.Char.level = self.Char.level + 1
		PrintLevel(self)
		LevelSound(self)
		self:SetNWInt("level", self.Char.level)
		self:SetNWInt("XP",self:GetXP())
		self:SetNWInt("XPNextLevel",self:GetNeededXP())
		self:SetNWInt( "MaxHealth", self:Health( ) )
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
      if ValidEntity( killer ) and killer:IsPlayer( ) and killer != victim then
             killer:AddXP( REWARD_XP )
             killer:Levelup( )
end
end

hook.Add( "PlayerDisconnected"	, "Level.PlDiscnct", _R.Player.Save 	)
hook.Add( "OnNPCKilled"		, "Level.NPCKilled", OnNPCKilled 	)
hook.Add( "PlayerDeath", "Level.PlayerDeath", PlayerDeath )
timer.Create( "SaveXP", 120, 0, AutoSave )

function playerRespawn( ply )
	if !ply.Char then return end
	local PlayerHP = 100 + ( ply.Char.level * 15 )
	ply:SetMaxHealth( PlayerHP )
	ply:SetHealth( PlayerHP )
	local PlayerSpeed = 200 + (ply.Char.level * 5)
	ply:SetWalkSpeed( PlayerSpeed ) 
	ply:SetRunSpeed( PlayerSpeed * 2 ) 
	ply:SetNWInt("XP",ply:GetXP())
	ply:SetNWInt("XPNextLevel",ply:GetNeededXP())
	ply:SetNWInt("level", ply.Char.level)
end

hook.Add( "PlayerSpawn", "SetPlayerStats", playerRespawn ) 

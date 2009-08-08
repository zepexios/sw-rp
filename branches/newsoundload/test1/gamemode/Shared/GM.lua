/****************    Lolwhut?    ************************
function SWO.Settings:Setup()
	GM.Name 	= SWO.Settings.Name
	GM.Author 	= SWO.Settings.Author
	GM.Email 	= SWO.Settings.Email
	GM.Website 	= SWO.Settings.Website
end

function GM:GetGameDescription()
	return SWO.Settings.Name
end

function GM:GetGamemodeDescription()
	return self:GetGameDescription()
end

function GM:Initialize()

	self.BaseClass:Initialize()

end

ST.Settings:Setup()
*/
--ALL FUNCTIONS above are commented, better to use --[[ and ]]--


function GM:PlayerDeathThink( pl )
	if (  pl.NextSpawnTime && pl.NextSpawnTime > CurTime() ) then return end
	--automatically spawn in time set below...
	--TODO: add counter here.
	pl:Spawn()
end

function GM:PlayerSilentDeath( Victim )
    Victim.NextSpawnTime = CurTime() + 99999
    Victim.DeathTime = CurTime()
end

function GM:PlayerDeath( Victim, Inflictor, Attacker )
        // Don't spawn for at least 2 seconds
        Victim.NextSpawnTime = CurTime() + 4
        Victim.DeathTime = CurTime()
        if ( Inflictor && Inflictor == Attacker && (Inflictor:IsPlayer() || Inflictor:IsNPC()) ) then
                Inflictor = Inflictor:GetActiveWeapon()
                if ( !Inflictor || Inflictor == NULL ) then Inflictor = Attacker end
        end
        if (Attacker == Victim) then
                umsg.Start( "PlayerKilledSelf" )
                        umsg.Entity( Victim )
                umsg.End()
                MsgAll( Attacker:Nick() .. " suicided!\n" )
        return end
        if ( Attacker:IsPlayer() ) then
                umsg.Start( "PlayerKilledByPlayer" )
                        umsg.Entity( Victim )
                        umsg.String( Inflictor:GetClass() )
                        umsg.Entity( Attacker )
                umsg.End()
                MsgAll( Attacker:Nick() .. " killed " .. Victim:Nick() .. " using " .. Inflictor:GetClass() .. "\n" )
        return end
        umsg.Start( "PlayerKilled" )
                umsg.Entity( Victim )
                umsg.String( Inflictor:GetClass() )
                umsg.String( Attacker:GetClass() )
        umsg.End()
        MsgAll( Victim:Nick() .. " was killed by " .. Attacker:GetClass() .. "\n" )
end
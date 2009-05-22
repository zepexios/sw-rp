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
 
 ply:SetTeam( 1 )
 
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
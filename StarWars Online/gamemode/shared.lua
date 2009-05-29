AddCSLuaFile("cl_init.lua")
AddCSLuaFile('cl_hud')
include('quests.lua')
include('init.lua')
include('cl_init.lua')
include('ServerSettings.lua')
include('cl_hud')

local PlayerInfo = SWReadPlayerData( ply )
local CombatLvl = PlayerInfo.CombatLvl 

local CivColor = GM:SWGetClassInfo( "Civilian", CombatLvl )
local RebColor = GM:SWGetClassInfo( "Rebel", CombatLvl )
local ImpColor = GM:SWGetClassInfo( "Imperial", CombatLvl )
local MercColor = GM:SWGetClassInfo( "Mercenary", CombatLvl )


GM.Name 	= "StarWars RP"
GM.Author 	= "The Starwars RP Team"
GM.Email 	= "n/a"
GM.Website 	= "http://swrp.forumotion.net/index.htm?sid=19a5880a48d75552977020a9189c2628"

team.SetUp( 1, "Civilian", CivColor )
team.SetUp( 2, "Marksman", Color( 25, 100, 40, 255 ) )
team.SetUp( 3, "Rebel", RebColor)
team.SetUp( 4, "Imperial", ImpColor)
team.SetUp( 5, "Mercenary", MercColor)

function SWGetClassInfo( Team, CombatLvl )
	local Alpha = (ComatLvl * 2) + 105
	if( Team == "Rebel" ) then
		local Color = Color( 34, 139, 34, Alpha )
		return Color 
	end
	if( Team == "Imperial" ) then
		local Color = Color( 178, 34, 34, Alpha )
		return Color 
	end
	if( Team == "Mercenary" ) then
		local Color = Color( 25, 25, 112, Alpha )
		return Color 
	end
	if( Team == "Civilian" ) then
		local Color = Color( 49, 79, 79, Alpha )
		return Color 
	end
end
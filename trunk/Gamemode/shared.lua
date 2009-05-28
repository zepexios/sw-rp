include( 'cl_init.lua' )
include( 'login.lua' )
ply = LocalPlayer()
local PlayerInfo = SWReadPlayerData( ply ) // This calls a nil value the login script is not finished  which is why we are having so many errors
local CombatLvl = PlayerInfo.CombatLvl 

local CivColor = GM:SWGetClassInfo( "Civilian", CombatLvl )
local RebColor = GM:SWGetClassInfo( "Rebel", CombatLvl )
local ImpColor = GM:SWGetClassInfo( "Imperial", CombatLvl )
local MercColor = GM:SWGetClassInfo( "Mercenary", CombatLvl )


GM.Name 	= "StarWars RP" //Set the gamemode name
GM.Author 	= "The Starwars RP Team" //Set the author name
GM.Email 	= "n/a" //Set the author email
GM.Website 	= "http://swrp.forumotion.net/index.htm?sid=19a5880a48d75552977020a9189c2628" //Set the author website 

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
/* just in case... ; ) 
team.SetUp( 1, "Guest", Color( 5, 75, 0, 255 ) )
team.SetUp( 2, "Marksman", Color( 25, 100, 40, 255 ) )
team.SetUp( 3, "Rebel", Color( 34, 139, 34, 255 ) )
team.SetUp( 4, "Imperial", Color( 178, 34, 34, 255 ) )
team.SetUp( 5, "Mercenary", Color( 	49, 79, 79, 255 ) )
*/

 local randomweathers = {"sunny", "cloudy", "rain", "sunnyrain", "storm", "dark", "darkrain"}
function randomweather()
SetGlobalString("weather",table.Random( randomweathers ))
timer.Simple(math.random(10,300),randomweather)
end
randomweather()

function SW
































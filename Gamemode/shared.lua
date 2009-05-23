include( 'cl_init.lua' )
if(SERVER) then include( 'login.lua' ) end






GM.Name 	= "StarWars RP" //Set the gamemode name
GM.Author 	= "The Starwars RP Team" //Set the author name
GM.Email 	= "n/a" //Set the author email
GM.Website 	= "http://swrp.forumotion.net/index.htm?sid=19a5880a48d75552977020a9189c2628" //Set the author website 

team.SetUp( 1, "Guest", Color( 5, 75, 0, 255 ) )
team.SetUp( 2, "Marksman", Color( 25, 100, 40, 255 ) )
team.SetUp( 3, "Rebel", Color(GM:SWGetClassInfo( "Rebel" ) )
team.SetUp( 4, "Imperial", Color( 178, 34, 34, 255 ) )
team.SetUp( 5, "Mercenary", Color( 	49, 79, 79, 255 ) )


/*
team.SetUp( 1, "Guest", Color( 5, 75, 0, 255 ) )
team.SetUp( 2, "Marksman", Color( 25, 100, 40, 255 ) )
team.SetUp( 3, "Rebel", Color( 34, 139, 34, 255 ) )
team.SetUp( 4, "Imperial", Color( 178, 34, 34, 255 ) )
team.SetUp( 5, "Mercenary", Color( 	49, 79, 79, 255 ) )
*/



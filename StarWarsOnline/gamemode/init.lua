require( "datastream" ) // Datastream Module. DONT touch
require( "mysql" )    	// MySql Database module DONT touche ( doing so will wreck player banning and chars )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWO.LoadDirectory( "Server" )
SWO.LoadDirectory( "Shared" )
SWO.AddCSLuaDirectory( "Shared" )
SWO.AddCSLuaDirectory( "Client" )

// Lack of code you say?
// This file simply includes other files. Great for modules, not so sure about lag ^^

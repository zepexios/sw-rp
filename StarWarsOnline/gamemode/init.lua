require("datastream")

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )

SWO.LoadDirectory("Server")
SWO.AddCSLuaDirectory("Shared")
SWO.AddCSLuaDirectory("Client")










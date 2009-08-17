
require("datastream")
require("mysql")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWO.LoadDir("server/stand_alone/")
SWO.LoadDir("shared/stand_alone/")
SWO.LoadDir("shared/stand_alone/", true)
SWO.LoadDir("client/stand_alone/", true) --We REALLY DONT need a stand_alone folder for the client!
SWO.Debug("Loading Sounds...")
SWO.LoadResources("sound")
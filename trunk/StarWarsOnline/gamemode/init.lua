
require("datastream")
require("mysql")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWO.LoadDir("server/stand_alone/")
SWO.LoadDir("shared/", true)
SWO.LoadDir("client/", true)
SWO.LoadDir("sound/SWO/")
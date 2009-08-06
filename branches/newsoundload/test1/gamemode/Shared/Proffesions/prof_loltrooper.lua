local PROFFESION = {}

PROFFESION.Name = "LOL Trooper"
PROFFESION.Filename = "prof_loltrooper.lua"

function PROFFESION:Init(ply)
	ply:ChatPrint("You have switched to "..self.Name.." class!")
end

SWO_RegisterPROF(PROFFESION)
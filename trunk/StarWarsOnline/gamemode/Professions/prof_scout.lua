local PROF = {}

PROF.Name = "Scout"
PROF.Author = "iRzilla"
PROF.Filename = PROF_FILENAME
PROF.ClientSide = true
PROF.ServerSide = true


if (SERVER) then
	function PROF:Init(ply)
		ply:Kill()
		ply:ChatPrint("Changed to: "..PROF.Name.."Made by: "..PROF.Author)
	end
end

if (CLIENT) then

	function PROF:Init()
		print("LOL - "..PROF.Name)
	end

end

SWO_RegisterPROF(PROF)
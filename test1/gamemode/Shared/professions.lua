Proffesions = {}

function SWO.RegisterPROF( PROF )

	AddCSLuaFile("Proffesions/"..PROF.Filename)

	Msg("PROF -> " .. PROF.Name .. "\n")

	table.insert( SWO.Proffesions, PROF )

end

function SWO.LoadPROFs()

	DIR = "Proffesions"

	local luaFiles = file.FindInLua(DIR .. "/*.lua")

	for k,v in pairs(luaFiles) do
	
		PROF_FILENAME = DIR .. "/" .. v
		
		include( PROF_FILENAME )
		
	end

end

function _R.Player:SetProffesion( PROF )
	print("Player Switched Proffesion To: "..PROF.Name)

	if !table.HasValue(SWO.Proffesions, PROF) then return end

	self.CurrentChar.proffesion = PROF
	PROF:Init(self)
end

function _R.Player:GetProffesion()
	return self.CurrentChar.proffesion
end
SWO.Proffesions = {}

function SWO.RegisterPROF( PROF )

	AddCSLuaFile(GM.FolderName .. "/gamemode/Shared/Proffesions/"..PROF.Filename)

	SWO.Msg("PROF -> " .. PROF.Name)

	table.insert( SWO.Proffesions, PROF )

end

function SWO.LoadPROFs()

	SWO.Msg("Loading Proffesions ...");
	
	for _,v in pairs(file.FindInLua(GM.FolderName .. "/gamemode/Shared/Proffesions/*.lua")) do
	
		include( GM.FolderName .. "/gamemode/Shared/Proffesions/" .. v );
		SWO.Msg("included: " .. v);
		
	end

	SWO.Msg("Finished loading Proffesions!");
	
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
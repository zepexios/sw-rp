/****************    Lolwhut?    ************************
function SWO.Settings:Setup()
	GM.Name 	= SWO.Settings.Name
	GM.Author 	= SWO.Settings.Author
	GM.Email 	= SWO.Settings.Email
	GM.Website 	= SWO.Settings.Website
end

function GM:GetGameDescription()
	return SWO.Settings.Name
end

function GM:GetGamemodeDescription()
	return self:GetGameDescription()
end

function GM:Initialize()

	self.BaseClass:Initialize()

end

ST.Settings:Setup()
*/
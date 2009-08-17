/****************    Lolwhut?    ************************8
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

function GM:PlayerBindPress( ply, BIND, pressed )	// Blocks ConCommands; Add a new line with the format below to block a Cmd ..MGinshe..
	if SWO.DebugMode then return end
	if( string.find( BIND, "<Command>" ) ) then return true end
	if( string.find( BIND, "kill" ) ) then ply:PrintMessage( HUD_PRINTTALK , "Suicice is NOT the way!" ) return true end
	if( string.find( BIND, "+showscores" ) ) then return true end
end
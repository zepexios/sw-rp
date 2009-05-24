// Lib

SS.Lib = {}

// Include file

function SS.Lib.Include(Message)
	local File = Message:ReadString()
	
	// Include
	
	include(File)
end

usermessage.Hook("SS.Lib.Include", SS.Lib.Include)

// Get team colour

function SS.Lib.GetTeamColor(Player)
	Player = Player or SS.Client
	
	// Side
	
	local Side = LocalPlayer():Team()
	
	// Color
	
	local Col = team.GetColor(Side)
	
	// Return color
	
	return Col
end

// Hidden GUI

function SS.Lib.Hidden(Player, Type)
	return (Player:GetNetworkedInt("SS.Hidden: "..Type) == 1)
end
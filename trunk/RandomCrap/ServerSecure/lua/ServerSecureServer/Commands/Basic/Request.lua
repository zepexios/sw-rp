// Request

local Request = SS.ChatCommands:New("Request")

// Request command

function Request.Command(Player, Args)
	local ID = Args[1]
	
	table.remove(Args, 1)
	
	// Reason and file
	
	local Reason = table.concat(Args, " ")
	local File = ""
	
	// Check if it exists
	
	if (file.Exists("ServerSecure/Requests.txt")) then
		File = file.Read("ServerSecure/Requests.txt").."\n"
	end
	
	// Update file
	File = File.."[Request] "..Player:Name().." ("..Player:SteamID()..") requested "..ID..", Reason: '"..Reason.."'"
	
	// Write file
	
	file.Write("ServerSecure/Requests.txt", File)
	
	// Message
	
	SS.PlayerMessage(Player, ID.." has been requested!", 0)
end

// Create

Request:Create(Request.Command, {"Basic"}, "Request a new mod to be added", "<Name/Link> <Reason>", 2, " ")

// Advert

SS.Adverts.Add("Request new mods by typing "..SS.ChatCommands.Prefix().."request <Name> <Reason>")
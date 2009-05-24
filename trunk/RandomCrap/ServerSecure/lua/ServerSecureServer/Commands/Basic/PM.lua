// PM

local PM = SS.ChatCommands:New("PM")

// PM command

function PM.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Check
	
	if (Person) then
		local Message = table.concat(Args, " ", 2)
		
		// Message
		
		Player:PrintMessage(3, "(To: "..Person:Name()..") "..Message)
		Person:PrintMessage(3, "(From: "..Player:Name()..") "..Message)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

PM:Create(PM.Command, {"Basic"}, "Send a private message to a specific person", "<Player> <Message>", 2, " ")

// Advert

SS.Adverts.Add("Send a private message by typing "..SS.ChatCommands.Prefix().."pm <Name> <Message>")
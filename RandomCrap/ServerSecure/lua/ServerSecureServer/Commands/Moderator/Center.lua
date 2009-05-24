// Center

local Center = SS.ChatCommands:New("Center")

// Branch flag

SS.Flags.Branch("Moderator", "Center")

// Center command

function Center.Command(Player, Args)
	Args = table.concat(Args, " ")
	
	// Message
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		V:PrintMessage(4, Args)
		V:PrintMessage(2, Args)
	end
end

// Create

Center:Create(Center.Command, {"Moderator", "Center"}, "Print a message to the center of the screen", "<Message>", 1, " ")
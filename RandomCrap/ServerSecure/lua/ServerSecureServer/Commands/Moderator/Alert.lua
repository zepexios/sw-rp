// Alert

local Alert = SS.ChatCommands:New("Alert")

// Branch flag

SS.Flags.Branch("Moderator", "Alert")

// Alert command

function Alert.Command(Player, Args)
	Args = table.concat(Args, " ")
	
	// Message
	
	SS.PlayerMessage(0, Args, 4)
end

// Create

Alert:Create(Alert.Command, {"Moderator", "Alert"}, "Create an alert viewed by everybody", "<Message>", 1, " ")
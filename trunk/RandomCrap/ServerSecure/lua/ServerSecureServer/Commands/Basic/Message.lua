// Message

local Message = SS.ChatCommands:New("Message")

// Message command

function Message.Command(Player, Args)
	local Flag = Args[1]
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		if (SS.Flags.PlayerHas(V, Args[1]) or V == Player) then
			local Message = table.concat(Args, ", ", 2)
			
			// Message
			
			SS.PlayerMessage(V, "(To Flag: '"..Args[1].."') "..Player:Name()..": "..Message, 0)
		end
	end
end

Message:Create(Message.Command, {"Basic"}, "Send message to people with certain flags", "<Flag>, <Text>", 2, ", ")
// Commands

local Commands = SS.ChatCommands:New("Commands")

// Commands command

function Commands.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Commands")
	
	// Loop
	
	for K, V in pairs(SS.ChatCommands.List) do
		if (SS.Flags.PlayerHas(Player, V.Restrict)) then
			Panel:Button(SS.ChatCommands.Prefix()..K, 'ss commandscommand '..K..'')
		end
	end
	
	// Send
	
	Panel:Send()
end

// View command

function Commands.View(Player, Args)
	for K, V in pairs(SS.ChatCommands.List) do
		if (K == Args[1]) then
			local Panel = SS.Panel:New(Player, SS.ChatCommands.Prefix()..K)
			
			// Words
			
			Panel:Words("Help: "..V.Help)
			Panel:Words("Syntax: "..V.Syntax)
			
			// Send
			
			Panel:Send()
			
			// Return
			
			return
		end
	end
	
	// Message
	
	SS.PlayerMessage(Player, "No such command: '"..Args[1].."'!", 1, ", ")
end

SS.ConsoleCommands.Simple("commandscommand", Commands.View, 1)

// Create

Commands:Create(Commands.Command, {"Basic"}, "View commands you can do")

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."commands to see what commands you can do")
// Who

local Who = SS.ChatCommands:New("Who")

// Who command

function Who.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Who")
	
	// Loop
	
	for K, V in pairs(SS.Who.List) do
		Panel:Button(K, 'ss whocommand '..K..'')
	end
	
	// Send
	
	Panel:Send()
end

// View

function Who.Console(Player, Args)
	local Index = Args[1]
	
	// List
	
	if (SS.Who.List[Index]) then
		local Panel = SS.Panel:New(Player, Index)
		
		// Done
		
		local Done = false
		
		// Players
		
		local Players = player.GetAll()
		
		// Loop
		
		for K, V in pairs(Players) do
			local Bool, Message = SS.Who.List[Index](V)
			
			// Bool
			
			if (Bool) then
				local Info = V:Name()
				
				// Message
				
				if (Message) then
					Info = Info.." - "..Message
				end
				
				// Text
				
				Panel:Words(Info)
				
				// Done
				Done = true
			end
		end
		
		// Done
		
		if not (Done) then
			Panel:Words("No players are currently doing this activity!")
		end
		
		// Send
		
		Panel:Send()
	else
		SS.PlayerMessage(Player, "There is no such Who module: '"..Index.."'!", 1)
	end
end

SS.ConsoleCommands.Simple("whocommand", Who.Console, 1, ", ")

// Create it

Who:Create(Who.Command, {"Basic"}, "See who is doing what")
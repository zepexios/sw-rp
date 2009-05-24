// Take warning

local TakeWarning = SS.ChatCommands:New("TakeWarning")

// Branch flag

SS.Flags.Branch("Administrator", "TakeWarning")

// Take warning command

function TakeWarning.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Warnings = Args[2]
		
		// Check warnings
		
		if not (Warnings) or (Warnings <= 0) then SS.PlayerMessage(Player, "That amount of warnings is too small!", 1) return end
		
		// Remove
		
		table.remove(Args, 1)
		table.remove(Args, 1)
		
		// Reason
		
		local Reason = table.concat(Args, " ")
		
		// Deduct
		
		SS.Warnings.Deduct(Person, Warnings, Reason)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

TakeWarning:Create(TakeWarning.Command, {"Administrator", "TakeWarning"}, "Take a warning from somebody", "<Player> <Amount> <Reason>", 3, " ")
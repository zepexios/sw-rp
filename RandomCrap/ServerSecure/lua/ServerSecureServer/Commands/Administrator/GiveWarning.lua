// Give warning

local GiveWarning = SS.ChatCommands:New("GiveWarning")

// Branch flag

SS.Flags.Branch("Administrator", "GiveWarning")

// Give warning command

function GiveWarning.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "GiveWarning")
		
		if (Error) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Warnings
		
		local Warnings = Args[2]
		
		// Check warnings
		
		if not (Warnings) or (Warnings <= 0) then SS.PlayerMessage(Player, "That amount of warnings is too small!", 1) return end
		
		// Reason
		
		local Reason = table.concat(Args, " ", 3)
		
		// Warn
		
		SS.Warnings.Warn(Person, Warnings, Reason)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

GiveWarning:Create(GiveWarning.Command, {"Administrator", "GiveWarning"}, "Give somebody a warning", "<Player> <Amount> <Reason>", 3, " ")
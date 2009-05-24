// Freeze

local Frozen = SS.ChatCommands:New("Freeze")

// Branch flag

SS.Flags.Branch("Moderator", "Freeze")

// Freeze command

function Frozen.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Freeze")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Check
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has frozen "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has unfrozen "..Person:Name().."!", 0)
		end
		
		// Freeze
		
		SS.Lib.PlayerFreeze(Person, Bool)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Frozen:Create(Frozen.Command, {"Moderator", "Freeze"}, "Freeze a specific player", "<Player> <1|0>", 2, " ")
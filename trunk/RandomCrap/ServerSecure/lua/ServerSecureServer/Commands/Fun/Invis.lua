// Invis

local Invis = SS.ChatCommands:New("Invis")

// Branch flag

SS.Flags.Branch("Fun", "Invis")

// Invis command

function Invis.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Invis")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Message
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has made "..Person:Name().." invisible!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has made "..Person:Name().." visible!", 0)
		end
		
		// Make invisible
		
		SS.Lib.PlayerInvis(Person, Bool)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Invis:Create(Invis.Command, {"Fun", "Invis"}, "Turn somebody invisible", "<Player> <1|0>", 2, " ")
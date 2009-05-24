// Ignite

local Ignited = SS.ChatCommands:New("Ignite")

// Branch flag

SS.Flags.Branch("Moderator", "Ignite")

// Ignite command

function Ignited.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Ignite")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Check
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has ignited "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has extinguished "..Person:Name().."!", 0)
		end
		
		// Ignite
		
		SS.Lib.PlayerIgnite(Person, Bool)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Ignited:Create(Ignited.Command, {"Moderator", "Ignite"}, "Ignite a specific player", "<Player> <1|0>", 2, " ")
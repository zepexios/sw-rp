// Slay

local Slay = SS.ChatCommands:New("Slay")

// Branch flag

SS.Flags.Branch("Moderator", "Slay")

// Slay command

function Slay.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Slay")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has slayed "..Person:Name().."!", 0)
		
		// Slay
		
		SS.Lib.PlayerSlay(Person)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Slay:Create(Slay.Command, {"Moderator", "Slay"}, "Slay a specific player", "<Player>", 1, " ")
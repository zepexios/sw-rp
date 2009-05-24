// Kick

local Kick = SS.ChatCommands:New("Kick")

// Branch flag

SS.Flags.Branch("Moderator", "Kick")

// Kick command

function Kick.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Reason
	
	local Reason = table.concat(Args, " ", 2)
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Kick")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has kicked "..Person:Name().." ("..Reason..")!", 0)
		
		// Kick
		
		SS.Lib.PlayerKick(Person, Reason)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Kick:Create(Kick.Command, {"Moderator", "Kick"}, "Kick a specific player", "<Player> <Reason>", 2, " ")
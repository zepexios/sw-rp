// Cleanup

local Cleanup = SS.ChatCommands:New("Cleanup")

// Branch flag

SS.Flags.Branch("Administrator", "Cleanup")

// Cleanup command

function Cleanup.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Cleanup")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Cleanup
		
		cleanup.CC_Cleanup(Person, "gmod_cleanup", {})
		
		// Message
		
		SS.PlayerMessage(Player, Player:Name().." cleaned up "..Person:Name().."'s entities!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

Cleanup:Create(Cleanup.Command, {"Administrator", "Cleanup"}, "Cleanup a player's entities", "<Player>", 1, " ")
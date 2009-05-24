// Mute

local Mute = SS.ChatCommands:New("Mute")

// Branch flag

SS.Flags.Branch("Moderator", "Mute")

// Mute command

function Mute.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Mute")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Allow
		
		SS.Allow.PlayerAllow(Person, "Mute", "Chat", Bool)
		
		// Bool
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has muted "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has unmuted "..Person:Name().."!", 0)
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Mute:Create(Mute.Command, {"Moderator", "Mute"}, "Mute a specific player", "<Player> <1|0>", 2, " ")
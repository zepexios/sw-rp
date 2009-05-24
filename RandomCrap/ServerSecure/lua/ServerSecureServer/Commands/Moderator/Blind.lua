// Blind

local Blind = SS.ChatCommands:New("Blind")

// Branch flag

SS.Flags.Branch("Moderator", "Blind")

// Blind command

function Blind.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Blind")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Check
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has blinded "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has unblinded "..Person:Name().."!", 0)
		end
		
		// Blind
		
		SS.Lib.PlayerBlind(Person, Bool)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

Blind:Create(Blind.Command, {"Moderator", "Blind"}, "Blind a specific player", "<Player> <1|0>", 2, " ")
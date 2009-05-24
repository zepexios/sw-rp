// God

local God = SS.ChatCommands:New("God")

// Branch flag

SS.Flags.Branch("Fun", "God")

// God command

function God.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Bool
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has godded "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has ungodded "..Person:Name().."!", 0)
		end
		
		// God
		
		SS.Lib.PlayerGod(Person, Bool)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

God:Create(God.Command, {"Fun", "God"}, "God a specific player", "<Player> <1|0>", 2, " ")
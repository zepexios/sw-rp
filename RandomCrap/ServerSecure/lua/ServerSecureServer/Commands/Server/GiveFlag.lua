// Give flag

local GiveFlag = SS.ChatCommands:New("GiveFlag")

// Branch flag

SS.Flags.Branch("Server", "GiveFlag")

// Give flag command

function GiveFlag.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Flag = SS.Flags.PlayerGive(Person, Args[2])
		
		// Already has it
		
		if not (Flag) then SS.PlayerMessage(Player, Person:Name().." already has flag '"..Args[2].."'!", 1) return end
		
		// Message
		
		SS.PlayerMessage(Player, "You have given "..Person:Name().." the '"..Args[2].."' flag.", 0)
		SS.PlayerMessage(Person, "You were given the '"..Args[2].."' flag by "..Player:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

GiveFlag:Create(GiveFlag.Command, {"GiveFlag", "Server"}, "Give a flag to somebody", "<Player> <Flag>", 2, " ")
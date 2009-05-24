// Take flag

local TakeFlag = SS.ChatCommands:New("TakeFlag")

// Branch flag

SS.Flags.Branch("Server", "TakeFlag")

// Take flag command

function TakeFlag.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "TakeFlag")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Take flag
		
		local Flag = SS.Flags.PlayerTake(Person, Args[2])
		
		// Doesn't have flag
		
		if not (Flag) then SS.PlayerMessage(Player, Person:Name().." doesn't have flag '"..Args[2].."'!", 1) return end
		
		// Message
		
		SS.PlayerMessage(Player, "You have taken the '"..Args[2].."' flag from "..Person:Name().."!", 0)
		SS.PlayerMessage(Person, "The '"..Args[2].."' flag was taken from you by "..Player:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

TakeFlag:Create(TakeFlag.Command, {"TakeFlag", "Server"}, "Take a flag from somebody", "<Player> <Flag>", 2, " ")
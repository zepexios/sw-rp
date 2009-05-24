// Set HP

local SetHP = SS.ChatCommands:New("SetHP")

// Branch flag

SS.Flags.Branch("Fun", "SetHP")

// Set HP command

function SetHP.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		Person:SetHealth(Args[2])
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." set "..Person:Name().."'s HP to "..Args[2].."!")
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

SetHP:Create(SetHP.Command, {"Fun", "SetHP"}, "Set a specific player's HP", "<Player> <Amount>", 2, " ")
// Goto

local Goto = SS.ChatCommands:New("Goto")

// Branch flag

SS.Flags.Branch("Fun", "Goto")

// Goto command

function Goto.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		Player:SetPos(Person:GetPos())
		
		// Message
		
		SS.PlayerMessage(Player, "You have gone to "..Person:Name().."!", 1)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Goto:Create(Goto.Command, {"Fun", "Goto"}, "Goto a specific player", "<Player>", 1, " ")
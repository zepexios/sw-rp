// Clear purchases

local Command = SS.ChatCommands:New("ClearPurchases")

// Branch flag

SS.Flags.Branch("Server", "ClearPurchases")

// Give purchase command

function Command.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		CVAR.Update(Person, "Purchases", {})
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has emptied "..Person:Name().."'s purchases list!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"Server", "ClearPurchases"}, "Clear all of somebodies purchases", "<Player>", 1, " ")
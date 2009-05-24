// Give purchase

local Command = SS.ChatCommands:New("GivePurchase")

// Branch flag

SS.Flags.Branch("Server", "GivePurchase")

// Give

function Command.Give(Player, Unique, Index, Friendly)
	Unique = tostring(Unique)
	
	// Person
	
	local Person = player.GetByUniqueID(Unique)
	
	// Person
	
	if (Person) then
		SS.Purchases.PlayerGive(Person, Index, Friendly)
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." gave purchase '"..Index.."' to "..Person:Name().."!", 0)
	end
end

// Give purchase command

function Command.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Panel = SS.Panel:New(Player, "Give Purchase")
		
		// Loop
		
		for K, V in pairs(SS.Purchases.List) do
			Panel:Button(V[1], {Command.Give, Person:UniqueID(), V[1], V[5]})
		end
		
		// Send
		
		Panel:Send()
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"GivePurchase", "Server"}, "Give a purchase to somebody", "<Player>", 1, " ")
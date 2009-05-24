// Take purchase

local Command = SS.ChatCommands:New("TakePurchase")

// Branch flag

SS.Flags.Branch("Server", "TakePurchase")

// Take purchase command

function Command.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "TakePurchase")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Purchase
		
		local Purchase = table.concat(Args, " ", 2)
		
		// Check if player has the purchase
		
		if (SS.Purchases.PlayerHas(Person, Purchase)) then
			SS.Purchases.PlayerTake(Person, Purchase)
			
			// Message
			
			SS.PlayerMessage(0, Player:Name().." removed purchase '"..Purchase.."' from "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(Player, Person:Name().." hasn't purchased '"..Purchase.."'!", 1)
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"TakePurchase", "Server"}, "Take a purchase from somebody", "<Player> <Purchase>", 2, " ")
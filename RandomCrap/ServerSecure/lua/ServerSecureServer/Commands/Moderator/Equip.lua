// Equip

local Equip = SS.ChatCommands:New("Equip")

// Allowed

Equip.Allowed = {
	"weapon_",
	"item_"
}

// Branch flag

SS.Flags.Branch("Moderator", "Equip")

// Equip command

function Equip.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		for K, V in pairs(Equip.Allowed) do
			if (string.find(string.lower(Args[2]), string.lower(V))) then
				Person:Give(Args[2])
				
				// Message
				
				SS.PlayerMessage(Player, "You gave "..Person:Name().." "..Args[2].."!", 0)
				
				if (Person == Player) then return end
				
				// Message
				
				SS.PlayerMessage(Person, "You were given "..Args[2].." by "..Player:Name().."!", 0)
				
				return
			end
		end
		
		// Message
		
		SS.PlayerMessage(Player, "This item is not allowed to be equipped!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Equip:Create(Equip.Command, {"Moderator", "Equip"}, "Equip a specific player with an item", "<Player> <Item>", 2, " ")
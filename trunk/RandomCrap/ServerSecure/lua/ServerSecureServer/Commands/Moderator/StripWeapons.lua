// Strip weapons

local Strip = SS.ChatCommands:New("StripWeapons")

// Branch flag

SS.Flags.Branch("Moderator", "StripWeapons")

// Freeze command

function Strip.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "StripWeapons")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Strip weapons
		
		Person:StripWeapons()
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has stripped "..Person:Name().."'s weapons!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

Strip:Create(Strip.Command, {"Moderator", "StripWeapons"}, "Strip a specific player's weapons", "<Player>", 1, " ")
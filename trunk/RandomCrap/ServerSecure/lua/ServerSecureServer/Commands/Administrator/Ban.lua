// Ban

local Ban = SS.ChatCommands:New("Ban")

// Branch flag

SS.Flags.Branch("Administrator", "Ban")

// Ban command

function Ban.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	local Reason = table.concat(Args, " ", 3)
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Ban")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Ban
		
		SS.Lib.PlayerBan(Person, Args[2], Reason, true)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Ban:Create(Ban.Command, {"Administrator", "Ban"}, "Ban a specific player", "<Player> <Time> <Reason>", 3, " ")
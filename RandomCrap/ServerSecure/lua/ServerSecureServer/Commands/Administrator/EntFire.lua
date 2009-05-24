// Ent fire

local EntFire = SS.ChatCommands:New("EntFire")

// Branch flag

SS.Flags.Branch("Administrator", "EntFire")

// Ban command

function EntFire.Command(Player, Args)
	// Trace
	
	local Trace = Player:ServerSecureTraceLine()
	
	// Entity
	
	if (Trace.Entity) then
		Trace.Entity:Fire(Args[1], Args[2], Args[3])
		
		// Message
		
		SS.PlayerMessage(Player, "Input "..Args[1].." ("..Args[2]..") ran on entity with delay of "..Args[3].."!", 0)
	else
		SS.PlayerMessage(Player, "You must aim at a valid entity!", 1)
	end
end

EntFire:Create(EntFire.Command, {"Administrator", "EntFire"}, "Use an entfire command on an entity", "<Input>, <Parameter>, <Delay>", 3, ", ")
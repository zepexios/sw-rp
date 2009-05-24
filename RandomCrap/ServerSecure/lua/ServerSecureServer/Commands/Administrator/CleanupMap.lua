// Cleanup map

local CleanupMap = SS.ChatCommands:New("CleanupMap")

// Branch flag

SS.Flags.Branch("Administrator", "CleanupMap")

// CleanupMap command

function CleanupMap.Command(Player, Args)
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		cleanup.CC_Cleanup(V, "gmod_cleanup", {})
	end
	
	// Message
	
	SS.PlayerMessage(Player, Player:Name().." cleaned up all entities on the map!", 0)
end

// Create

CleanupMap:Create(CleanupMap.Command, {"Administrator", "CleanupMap"}, "Cleanup all entities on the map")
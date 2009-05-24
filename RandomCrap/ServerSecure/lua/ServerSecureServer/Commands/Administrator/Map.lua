// Map

local Map = SS.ChatCommands:New("Map")

// Branch flag

SS.Flags.Branch("Administrator", "Map")

// Map command

function Map.Command(Player, Args)
	// Check it exists
	
	if not (file.Exists("../maps/"..Args[1]..".bsp")) then
		SS.PlayerMessage(0, "The map "..Args[1].." doesn't exist!", 1)
		
		// Return
		
		return
	end
	
	// Message
	
	SS.PlayerMessage(0, "Changing map to "..Args[1].." in 5 seconds!", 0)
	
	// Change map
	
	timer.Simple(5, game.ConsoleCommand, "changelevel "..Args[1].."\n")
end

Map:Create(Map.Command, {"Administrator", "Map"}, "Change the map", "<Name>", 1, " ")
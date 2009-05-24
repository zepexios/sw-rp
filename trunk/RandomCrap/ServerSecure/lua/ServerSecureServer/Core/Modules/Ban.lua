// Ban

SS.Ban      = {} // Ban table
SS.Ban.List = {} // Ban list

// Add a ban

function SS.Ban.Add(ID, Reason)
	SS.Ban.List[ID] = Reason
end

// PlayerInitialSpawn hook

function SS.Ban.PlayerInitialSpawn(Player)
	local ID = Player:SteamID()
	
	// Check
	
	if (SS.Ban.List[ID]) then
		SS.Lib.PlayerBan(Player, 0, SS.Ban.List[ID], true)
	end
end

// Hook into player initial spawn

SS.Hooks.Add("SS.Ban.PlayerInitialSpawn", "PlayerInitialSpawn", SS.Ban.PlayerInitialSpawn)
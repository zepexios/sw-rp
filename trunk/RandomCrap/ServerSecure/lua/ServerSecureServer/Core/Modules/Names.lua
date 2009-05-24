// Names

SS.Names = {}

// When player spawns

function SS.Names.PlayerInitialSpawn(Player)
	local ID = Player:Name()
	
	// TVAR
	
	TVAR.New(Player, "Name", ID)
end

SS.Hooks.Add("SS.Names.PlayerInitialSpawn", "PlayerInitialSpawn", SS.Names.PlayerInitialSpawn)

// ServerSecond hook

function SS.Names.ServerSecond(Player)
	local Players = player.GetAll()
	
	for K, V in pairs(Players) do
		local Ready = V:IsPlayerReady()
		
		// Ready
		
		if (Ready) then
			local ID = V:Name()
			
			// TVAR
			
			if not (TVAR.Request(V, "Name") == ID) then
				local New = ID
				
				// Backup
				
				local Backup = TVAR.Request(V, "Name")
				
				// TVAR
				
				TVAR.Update(V, "Name", New)
				
				// Hook
				
				SS.Hooks.Run("PlayerNameChanged", V, Backup, New)
			end
		end
	end
end

// Hook into server second

SS.Hooks.Add("SS.Names.ServerSecond", "ServerSecond", SS.Names.ServerSecond)
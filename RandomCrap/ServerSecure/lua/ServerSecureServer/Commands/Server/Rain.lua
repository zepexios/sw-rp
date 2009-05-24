// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Rain

local Rain = SS.ChatCommands:New("Rain")

// Branch flag

SS.Flags.Branch("Server", "Rain")

// Rain command

function Rain.Command(Player, Args)
	local Pos = Vector(0, 0, 3096)
	
	// Spread
	
	local Spread = Args[3]
	
	// Undo
	
	undo.Create("Points")
	
	// Loop
	
	for I = 1, Args[1] do
		local Entity = ents.Create("Points")
		
		// Set position
		
		Entity:SetPos(Pos + Vector(math.random(-Spread, Spread) * I, math.random(-Spread, Spread) * I, math.random(-Spread, Spread)))
		
		// Amount
		
		Entity.Amount = Args[2]
		
		// Spawn
		
		Entity:Spawn()
		
		// Set player
		
		Entity:SetPlayer(Player)
		
		// Check if the entity is in the world
		
		if not (Entity:IsInWorld()) then
			Entity:Remove()
		else
			Player:AddCount("props", Entity)
			Player:AddCleanup("props", Entity)
			
			// Add entity to undo
			
			undo.AddEntity(Entity)
		end
	end
	
	// Set player and finish
	
	undo.SetPlayer(Player)
	undo.Finish()
	
	// Message
	
	SS.PlayerMessage(0, "It's raining "..SS.Config.Request("Points Name").." and each one is worth "..Args[2].."!", 0)
end

Rain:Create(Rain.Command, {"Rain", "Server"}, "Points rain from the sky", "<Count> <Amount> <Spread>", 3, " ")
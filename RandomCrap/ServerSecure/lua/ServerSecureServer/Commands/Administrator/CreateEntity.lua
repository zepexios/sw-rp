// Create entity

local CreateEntity = SS.ChatCommands:New("CreateEntity")

// Branch flag

SS.Flags.Branch("Administrator", "CreateEntity")

// Create entity command

function CreateEntity.Command(Player, Args)
	// Trace
	
	local Trace = Player:ServerSecureTraceLine()
	
	// Entity
	
	local Entity = ents.Create(Args[1])
	
	// Entity is valid
	
	if (Entity) then
		table.remove(Args, 1)
		
		// Position
		
		Entity:SetPos(Trace.HitPos + Vector(0, 0, 64))
		
		// Loop
		
		for K, V in pairs(Args) do
			V = tostring(V)
			
			// Explode
			
			local Explode = string.Explode(":", V)
			
			if (Explode[1] and Explode[2]) then
				Entity:SetKeyValue(Explode[1], Explode[2])
			end
		end
		
		// Spawn
		
		Entity:Spawn()
		
		// Check
		
		if (Entity) then
			local Valid = Entity:IsValid()
			
			if (Valid) then
				SS.PlayerMessage(Player, "The entity has been successfully created!", 0)
				
				// Return true
				
				return true
			end
		end
		
		// Message
		
		SS.PlayerMessage(Player, "The entity you created was not valid!", 1)
	else
		SS.PlayerMessage(Player, "The entity you created was not valid!", 1)
	end
end

// Create

CreateEntity:Create(CreateEntity.Command, {"Administrator", "CreateEntity"}, "Create an entity using key values", "<Class>, <Key:Value>, <Key:Value>", 2, ", ")
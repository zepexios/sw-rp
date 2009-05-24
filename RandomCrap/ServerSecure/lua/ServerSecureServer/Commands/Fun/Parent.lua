// Parent

local Parent = SS.ChatCommands:New("Parent")

// Branch flag

SS.Flags.Branch("Fun", "Parent")

// Parent command

function Parent.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Trace = Player:ServerSecureTraceLine()
		
		// Trace entity
		
		if not (Trace.Entity) then
			SS.PlayerMessage(Player, "You must aim at a valid entity!", 1)
			
			// Return
			
			return
		end
		
		// World
		
		local World = Trace.Entity:IsWorld()
		
		if (World) then
			SS.PlayerMessage(Player, "You cannot set the world's parent!", 1)
			
			// Return
			
			return
		end
		
		// Set parent
		
		Trace.Entity:SetParent(Person)
		
		// Message
		
		SS.PlayerMessage(Player, "Entity has been parented to "..Person:Name().."!", 0)
		
		// Function
		
		local function Function(Undo, Entity)
			local Valid = SS.Lib.Valid(Entity)
			
			if (Valid) then
				Entity:SetParent()
			end
		end
		
		// Undo
		
		undo.Create("Parent")
			undo.SetPlayer(Player)
			undo.AddFunction(Function, Trace.Entity)
		undo.Finish()
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Parent:Create(Parent.Command, {"Fun", "Parent"}, "Parent target entity to a player", "<Player>", 1, " ")
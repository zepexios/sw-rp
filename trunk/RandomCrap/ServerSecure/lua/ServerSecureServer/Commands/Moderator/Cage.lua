// Cage (Idea by Megiddo)

local Cage = SS.ChatCommands:New("Cage")

// Branch flag

SS.Flags.Branch("Moderator", "Cage")

// Positions

Cage.Positions = {
	{Vector(0, 0, 0), Angle(-0.032495182007551, -90.190528869629, 0.156479626894)},
	{Vector(129.97778320313, -127.38626098633, -0.13224792480469), Angle(0.12636932730675, 179.84873962402, 0.025045685470104)},
	{Vector(2.905517578125, -258.35272216797, -0.79289245605469), Angle(-3.4093172871508e-005, -90, 5.7652890973259e-005)},
	{Vector(-123.9228515625, -127.88626098633, -1.0640182495117), Angle(-0.00059019651962444, 179.99681091309, 359.99996948242)},
	{Vector(-63.728271484375, -129.30960083008, -63.381893157959), Angle(-89.999015808105, -179.42805480957, 180)},
	{Vector(62.65771484375, -131.56051635742, -63.381889343262), Angle(-89.999015808105, 179.91276550293, 180)},
	{Vector(64.22265625, -127.65585327148, 65.902130126953), Angle(-89.77417755127, -156.53060913086, 336.46817016602)},
	{Vector(-64.297607421875, -124.14590454102, 65.455322265625), Angle(-89.825218200684, -132.09020996094, 312.04119873047)}
}

// Modle

Cage.Model = "models/props_wasteland/interior_fence002d.mdl"

// Cage

function Cage.Uncage(Entity, Player, Entities)
	if (TVAR.Request(Player, "Caged")) then
		SS.PlayerMessage(0, Player:Name().." has been uncaged!", 0)
		
		// Allow
		
		SS.Allow.PlayerAllow(Player, "Cage", "Commands", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Tool", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Physgun", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Spawn", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Weapons", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Death", true)
		SS.Allow.PlayerAllow(Player, "Cage", "Noclip", true)
		
		// Remove all entities
		
		for K, V in pairs(Entities) do
			V:Remove()
		end
		
		// Caged
		
		TVAR.Update(Player, "Caged", false)
	end
end

// Cage command

function Cage.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Cage")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Check if we should cage them
		
		if (Bool) then
			// Freeze player
			
			Person:Freeze(true)
			
			// Position
			
			local Position = Person:GetPos() + Vector(0, 128, 64)
			
			// Create the entities
			
			local Entities = {}
			
			for K, V in pairs(Cage.Positions) do
				local Entity = ents.Create("prop_physics")
				
				// Values
				
				Entity:SetModel(Cage.Model)
				Entity:SetPos(Position + V[1])
				Entity:SetAngles(V[2])
				Entity:Spawn()
				
				// Freeze it
				
				Entity:GetPhysicsObject():EnableMotion(false)
				
				// Add it to the entities table
				
				table.insert(Entities, Entity)
				
				// Weld
				
				if (Entities[K - 1]) then
					constraint.Weld(Entity, Entities[K - 1], 0, 0, 0, true)
				else
					constraint.Weld(Entity, GetWorldEntity(), 0, 0, 0, false)
				end
				
				// Disable some functions
				
				Entity.PhysgunDisabled = true
				Entity.CanTool = function() return false end
				
				// Add
				
				Player:AddCount("props", Entity)
				Player:AddCleanup("props", Entity)
				
				// Call on remove
				
				Entity:CallOnRemove("Cage", Cage.Uncage, Person, Entities)
			end
			
			// Set pos
			
			Player:SetPos(Player:GetPos() + Vector(0, 0, 16))
			
			// Cage
			
			TVAR.Update(Person, "Cages", Entities)
			
			// Disallow
			
			SS.Allow.PlayerAllow(Person, "Cage", "Commands", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Tool", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Physgun", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Spawn", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Weapons", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Death", false)
			SS.Allow.PlayerAllow(Person, "Cage", "Noclip", false)
			
			// Message
			
			SS.PlayerMessage(0, Person:Name().." has been caged!", 0)
			
			// Set movetype to walk and unfreeze
			
			Person:Freeze(false)
			Person:StripWeapons()
			Person:SetMoveType(MOVETYPE_WALK)
			
			// Caged
			
			TVAR.Update(Person, "Caged", true)
		else
			local Entities = TVAR.Request(Person, "Cages")
			
			for K, V in pairs(Entities) do
				if (V) then
					local Valid = V:IsValid()
					
					if (Valid) then V:Remove() end
				end
			end
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Cage:Create(Cage.Command, {"Moderator", "Cage"}, "Cage a specific player", "<Player> <1|0>", 2, " ")
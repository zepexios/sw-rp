// Ragdoll

local Ragdoll = SS.ChatCommands:New("Ragdoll")

// Branch flag

SS.Flags.Branch("Fun", "Ragdoll")

// Ragdoll command

function Ragdoll.Command(Player, Args)
	// Ghosting
	
	if (Player.Ghosting) then
		SS.PlayerMessage(Player, "You need to stop ghosting before you can start ragdolling!", 1)
		
		// Return
		
		return
	end
	
	// Not ragdolling
	
	if not (Player.Ragdoll) then
		// Entity
		
		local Entity = ents.Create("prop_ragdoll")
		
		Entity:SetModel(Player:GetModel())
		Entity:SetPos(Player:GetPos())
		Entity:Spawn()
		Entity:Activate()
		
		// Entity
		
		Player.Ragdoll = Entity
		
		// Spectate
		
		Ragdoll.Spectate(Player, Entity)
		
		// Hide GUI
		
		Player:HideServerSecureGUI("Ragdoll", "Hover", true)
		Player:HideServerSecureGUI("Ragdoll", "Name", true)
		
		// Message
		
		SS.PlayerMessage(Player, "You are now ragdolled!", 0)
	else
		Player:Spawn()
		
		// Message
		
		SS.PlayerMessage(Player, "You are unragdolled!", 0)
	end
end

// Return from ragdolling

function Ragdoll.Return(Player)
	// Valid
	
	if (SS.Lib.Valid(Player.Ragdoll)) then
		Player:SetPos(Player.Ragdoll:GetPos() + Vector(0, 0, 32))
		
		// Remove
		
		Player.Ragdoll:Remove()
	end
	
	// Show GUI
	
	Player:HideServerSecureGUI("Ragdoll", "Hover", false)
	Player:HideServerSecureGUI("Ragdoll", "Name", false)
end

// Spectate an entity

function Ragdoll.Spectate(Player, Entity)
	Player:Spectate(OBS_MODE_CHASE)
	Player:SpectateEntity(Entity)
	Player:StripWeapons()
end

// Respawn

function Ragdoll.Spawn(Player)
	// Ragdoll
	
	if (Player.Ragdoll) then
		Ragdoll.Return(Player)
	end
	
	// Ragdoll is nil
	
	Player.Ragdoll = nil
end

hook.Add("PlayerSpawn", "Ragdoll.Spawn", Ragdoll.Spawn)

// Player disconnect

function Ragdoll.Disconnected(Player)
	// Valid
	
	if (Player.Ragdoll and SS.Lib.Valid(Player.Ragdoll)) then
		Player.Ragdoll:Remove()
	end
	
	// Ragdoll is nil
	
	Player.Ragdoll = nil
end

hook.Add("PlayerDisconnected", "Ragdoll.Disconnected", Ragdoll.Disconnected)

// Who module

function Ragdoll.Who(Player)
	// Ragdoll
	
	if (Player.Ragdoll and SS.Lib.Valid(Player.Ragdoll)) then
		return true, Player.Ragdoll:GetModel()
	end
	
	// Return false
	
	return false
end

SS.Who.Module("Ragdolling", Ragdoll.Who)

// Create

Ragdoll:Create(Ragdoll.Command, {"Fun", "Ragdoll"}, "Turn into a ragdoll")
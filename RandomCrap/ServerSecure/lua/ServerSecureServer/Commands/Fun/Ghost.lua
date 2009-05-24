// Ghost

local Ghost = SS.ChatCommands:New("Ghost")

// Branch flag

SS.Flags.Branch("Fun", "Ghost")

// Ghost command

function Ghost.Command(Player, Args)
	// Ragdolling
	
	if (Player.Ragdoll) then
		SS.PlayerMessage(Player, "You need to stop ragdolling before you can start ghosting!", 1)
		
		// Return
		
		return
	end
	
	// Not ghosting
	
	if not (Player.Ghosting) then
		// Valid
		
		local TR = Player:ServerSecureTraceLine()
		
		if not (SS.Lib.Valid(TR.Entity)) then
			SS.PlayerMessage(Player, "You must aim at a valid entity!", 1)
			
			// Return
			
			return
		end
		
		// Is a player
		
		if (TR.Entity:IsPlayer()) then
			SS.PlayerMessage(Player, "You can not ghost players!", 1)
			
			// Return
			
			return
		end
		
		// Doesn't own
		
		if not (Player:IsEntityOwner(TR.Entity)) then
			SS.PlayerMessage(Player, "This is not your entity!", 1)
			
			// Return
			
			return
		end
		
		// Ghosting
		
		Player.Ghosting = TR.Entity
		
		// Spectate
		
		Ghost.Spectate(Player, TR.Entity)
		
		// Hide GUI
		
		Player:HideServerSecureGUI("Ghost", "Hover", true)
		Player:HideServerSecureGUI("Ghost", "Name", true)
		
		// Message
		
		SS.PlayerMessage(Player, "You are now ghosting!", 0)
	else
		Player:Spawn()
		
		SS.PlayerMessage(Player, "You are no longer ghosting!", 0)
	end
end

// Return from ghosting

function Ghost.Return(Player)
	// Valid
	
	if (SS.Lib.Valid(Player.Ghosting)) then
		Player:SetPos(Player.Ghosting:GetPos() + Vector(0, 0, 32))
	end
	
	// Show GUI
	
	Player:HideServerSecureGUI("Ghost", "Hover", false)
	Player:HideServerSecureGUI("Ghost", "Name", false)
end

// Spectate entity

function Ghost.Spectate(Player, Entity)
	Player:Spectate(OBS_MODE_CHASE)
	Player:SpectateEntity(Entity)
	Player:StripWeapons()
end

// Respawn

function Ghost.Spawn(Player)
	// Ghostng
	
	if (Player.Ghosting) then
		Ghost.Return(Player)
	end
	
	// Ghosting is nil
	
	Player.Ghosting = nil
end

hook.Add("PlayerSpawn", "Ghost.Spawn", Ghost.Spawn)

// Control entity

function Ghost.Control(Player)
	local Entity = Player.Ghosting
	
	// Valid
	
	if (SS.Lib.Valid(Entity)) then
		local Phys = Entity:GetPhysicsObject()
		
		// Valid
		
		if (SS.Lib.Valid(Phys)) then
			local Mass = Phys:GetMass() * 50
			
			// Holding forward
			
			if (Player:KeyDown(IN_FORWARD)) then
				Phys:ApplyForceCenter(Player:GetAimVector() * Mass)
			end
		end
	end
end

// Think function

Ghost.Time = 0

function Ghost.Think()
	local Time = RealTime()
	
	// Time
	
	if (Ghost.Time < Time) then
		local Players = player.GetAll()
		
		// Loop
		
		for K, V in pairs(Players) do
			// Ghosting
			
			if (V.Ghosting) then
				Ghost.Control(V)
			end
		end
		
		// Update time
		
		Ghost.Time = Time + 0.05
	end
end

hook.Add("Think", "Ghost.Think", Ghost.Think)

// Disconnect

function Ghost.Disconnected(Player)
	// Valid
	
	if (Player.Ghosting and SS.Lib.Valid(Player.Ghosting)) then
		Player.Ghosting:Remove()
	end
	
	// Ghosting is nil
	
	Player.Ghosting = nil
end

hook.Add("PlayerDisconnected", "Ghost.Disconnected", Ghost.Disconnected)

// Who module

function Ghost.Who(Player)
	if (Player.Ghosting and SS.Lib.Valid(Player.Ghosting)) then
		return true, Player.Ghosting:GetModel()
	end
	
	// Return false
	
	return false
end

SS.Who.Module("Ghosting", Ghost.Who)

// Create ghost

Ghost:Create(Ghost.Command, {"Fun", "Ghost"}, "Ghost an entity and move with arrow keys")
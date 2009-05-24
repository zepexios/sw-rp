// Rocket

local Rocket = SS.ChatCommands:New("Rocket")

// Branch flag

SS.Flags.Branch("Moderator", "Rocket")

// Rocket command

function Rocket.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Rocket")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Alive
		
		if not (Person:Alive()) then
			SS.PlayerMessage(Player, "This person is not alive!", 1)
			
			// Return
			
			return
		end
		
		// Message
		
		SS.PlayerMessage(0, Person:Name().." has been rocketed into the sky!", 0)
		
		// Velocity
		
		Person:SetVelocity(Vector(0, 0, 1500))
		
		// Color
		
		local Col = team.GetColor(Person:Team())
		
		// Smoke
		
		local Smoke = SS.Lib.CreateSmokeTrail(Person, {Col.r.." "..Col.g.." "..Col.b, "255 215 0"})
		
		// Delete on death
		
		Person:DeleteOnDeath(Smoke)
		
		// Explode
		
		timer.Simple(2, SS.Lib.EntityExplode, Person)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Rocket:Create(Rocket.Command, {"Moderator", "Rocket"}, "Cause a specific player to fly into the sky", "<Player>", 1, " ")
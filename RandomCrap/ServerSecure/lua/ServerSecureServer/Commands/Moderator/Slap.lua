// Slap

local Slap = SS.ChatCommands:New("Slap")

// Branch flag

SS.Flags.Branch("Moderator", "Slap")

// Slap command

function Slap.Command(Player, Args)
	if (Args[3] < 0) then
		SS.PlayerMessage(Player, "You can not slap with negative damage!", 1)
		
		// Return
		
		return
	end
	
	// Person and error
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Slap")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Function
		
		local function Slap(Player, Damage)
			local Dead = not Player:Alive()
			
			// Dead
			
			if (Dead) then return end
			
			// Velocity
			
			Person:SetVelocity(Vector(math.random(-1000, 1000), math.random(-500, 500), 1000))
			
			// Take damage
			
			Person:TakeDamage(Damage, Player)
		end
		
		// Slap
		
		timer.Create("SS.Slap: "..Player:UniqueID(), 1, Args[2], Slap, Player, Args[3])
		
		// Message
		
		SS.PlayerMessage(0, Person:Name().." has been slapped "..Args[2].." times with "..Args[3].." damage!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Slap:Create(Slap.Command, {"Moderator", "Slap"}, "Slap a specific player", "<Player> <Amount> <Damage>", 3, " ")
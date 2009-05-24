// Eat

local Eat = SS.ChatCommands:New("Eat")

// Branch flag

SS.Flags.Branch("Moderator", "Eat")

// Eat command

function Eat.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Eat")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Freeze
		
		Person:Freeze(true)
		
		// Function
		
		local function Function(Person)
			local NPC = ents.Create("npc_barnacle")
			
			// Spawn
			
			NPC:SetPos(Person:GetPos() + Vector(0, 0, 256))
			NPC:Spawn()
			NPC:Activate()
			
			// Delete on death
			
			Person:DeleteOnDeath(NPC)
		end
		
		// Message
		
		SS.PlayerMessage(0, Person:Name().." is being eaten!", 0)
		
		// Timer
		
		timer.Simple(1, Function, Person)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Eat:Create(Eat.Command, {"Moderator", "Eat"}, "Eat somebody", "<Player>", 1, " ")
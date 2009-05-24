// Teleport

local Teleport = SS.ChatCommands:New("Teleport")

// Branch flag

SS.Flags.Branch("Moderator", "Teleport")

// Teleport command

function Teleport.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Trace
	
	local Trace = Player:GetEyeTrace()
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Teleport")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Set pos
		
		Person:SetPos(Trace.HitPos)
		
		// Effect data
		
		local Effect = EffectData()
		
		// Effect settings
		
		Effect:SetEntity(V)
		Effect:SetOrigin(Trace.HitPos)
		Effect:SetStart(Trace.HitPos)
		Effect:SetScale(9999)
		Effect:SetMagnitude(250)
		
		// Effect
		
		util.Effect("ThumperDust", Effect)
		
		// Message
		
		SS.PlayerMessage(0, Person:Name().." has been teleported!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Teleport:Create(Teleport.Command, {"Moderator", "Teleport"}, "Teleport somebody", "<Player>", 1, " ")
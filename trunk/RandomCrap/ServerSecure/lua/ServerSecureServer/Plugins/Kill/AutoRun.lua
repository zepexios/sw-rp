// Kill

local Plugin = SS.Plugins:New("Kill")

// Table

Plugin.Kills = {}

// Enabled

Plugin.Enabled = true

// When player dies

function Plugin.PlayerDeath(Player, Attacker, Damage)
	// Real time
	
	local Time = RealTime()
	
	// Check
	
	local Check = Attacker:IsPlayer()
	
	if (Check) then
		Plugin.Kills[Attacker] = Plugin.Kills[Attacker] or 0
		
		// Check time
		
		if (Plugin.Kills[Attacker] < Time) then
			if (Attacker != Player) then
				SS.Warnings.Warn(Attacker, 1, "Killing")
			end
			
			// Kills
			
			Plugin.Kills[Attacker] = Time + 30
		end	
	end
end

// Chat command

local Killing = SS.ChatCommands:New("Killing")

function Killing.Command(Player, Args)
	local Bool = SS.Lib.StringBoolean(Args[1])
	
	// Set enabled or disabled
	
	Plugin.Enabled = Bool
	
	// Messages
	
	if (Bool) then
		SS.PlayerMessage(0, "You will now get warnings for killing!", 0)
	else
		SS.PlayerMessage(Player, "You will no longer get warnings for killing!", 0)
	end
end

Killing:Create(Killing.Command, {"Server", "Killing"}, "Enable/Disable warnings for killing", "<1|0>", 1, " ")

// Create

Plugin:Create()
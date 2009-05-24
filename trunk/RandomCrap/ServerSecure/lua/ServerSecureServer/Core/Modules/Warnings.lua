// Warnings

SS.Warnings = {} // Warnings

// Gain warn

function SS.Warnings.Warn(Player, Amount, Reason)
	if (SS.Flags.PlayerHas(Player, "Immune")) then return end
	
	// Update
	
	CVAR.Update(Player, "Warnings", CVAR.Request(Player, "Warnings") + Amount)
	
	// Check
	
	local Warnings = CVAR.Request(Player, "Warnings")
	
	// Check warnings
	
	if (Warnings < SS.Config.Request("Warnings")) then
		SS.PlayerMessage(0, Player:Name().." has gained "..Amount.." warnings, "..Warnings.."/"..SS.Config.Request("Warnings").."! (Reason: "..Reason..")", 1)
	else
		local Time = SS.Config.Request("Warnings Ban")
		
		// Update
		
		CVAR.Update(Player, "Warnings", 0)
		
		// Ban
		
		SS.Lib.PlayerBan(Player, Time, "Warnings: "..Warnings.."/"..SS.Config.Request("Warnings").." warnings", true)
	end
end

// Deduct warning

function SS.Warnings.Deduct(Player, Amount, Reason)
	// Update
	
	CVAR.Update(Player, "Warnings", math.max(CVAR.Request(Player, "Warnings") - Amount, 0))
	
	// Check
	
	local Warnings = CVAR.Request(Player, "Warnings")
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." has had "..Amount.." warnings deducted, "..Warnings.."/"..SS.Config.Request("Warnings").."! (Reason: "..Reason..")", 1)
end

// PlayerSetVariables hook

function SS.Warnings.PlayerSetVariables(Player)
	CVAR.New(Player, "Warnings", 0)
end

// Hook into player set variables

SS.Hooks.Add("SS.Warnings.PlayerSetVariables", "PlayerSetVariables", SS.Warnings.PlayerSetVariables)

// PlayerUpdateGUI hook

//function SS.Warnings.PlayerUpdateGUI(Player)
//	Player:SetNetworkedString(Player, "Warnings", "Warnings: "..CVAR.Request(Player, "Warnings"))
//end

// Hook into player set variables

//SS.Hooks.Add("SS.Warnings.PlayerUpdateGUI", "PlayerUpdateGUI", SS.Warnings.PlayerUpdateGUI)
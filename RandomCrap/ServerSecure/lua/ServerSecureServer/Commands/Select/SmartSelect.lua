// Smart select

local SmartSelect = SS.ChatCommands:New("SmartSelect")

// Smart select command

function SmartSelect.Command(Player, Args)
	Player.SmartSelect = not Player.SmartSelect
	
	// Toggle
	
	if not (Player.SmartSelect) then
		SS.PlayerMessage(Player, "Smart select has been disabled", 0)
	else
		SS.PlayerMessage(Player, "Smart select has been enabled", 0)
	end
end

// Think function

SmartSelect.Time = 0

// Think

function SmartSelect.Think()
	local Time = RealTime()
	
	// Check time
	
	if (SmartSelect.Time < Time) then
		local Players = player.GetAll()
		
		// Loop
		
		for K, V in pairs(Players) do
			if (V.SmartSelect) then
				local TR = V:ServerSecureTraceLine()
				
				// Trace entity
				
				if (TR.Entity) then
					local Index = TR.Entity:EntIndex()
					
					// TVAR
					
					if (TVAR.Request(V, "Selected") and TVAR.Request(V, "Selected")[Index]) then
						return
					else
						V:SelectEntity(TR.Entity)
					end
				end
			end
		end
		
		// Update time
		
		SmartSelect.Time = Time + 0.25
	end
end

SS.Hooks.Add("SmartSelect.Think", "ServerThink", SmartSelect.Think)

// Create

SmartSelect:Create(SmartSelect.Command, {"Basic"}, "Toggle smart select (hover over entities to select)")
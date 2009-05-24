// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Points

SS.Points = {}

// Gain points

function SS.Points.PlayerGain(Player, Amount)
	CVAR.Update(Player, "Points", CVAR.Request(Player, "Points") + Amount)

	// Run hook
	
	SS.Hooks.Run("PlayerGivenPoints", Player, Amount)
end

// Deduct points

function SS.Points.PlayerTake(Player, Amount)
	CVAR.Update(Player, "Points", CVAR.Request(Player, "Points") - Amount)
	
	// Run hook
	
	SS.Hooks.Run("PlayerTakenPoints", Player, Amount)
end

// PlayerUpdateGUI hook

function SS.Points.PlayerUpdateGUI(Player)
	Player:SetNetworkedString("Points", SS.Config.Request("Points Name")..": "..CVAR.Request(Player, "Points"))
	Player:SetNetworkedString("Timer", SS.Config.Request("Points Name").." Timer: "..CVAR.Request(Player, "Timer"))
end

// Hook into player update GUI

SS.Hooks.Add("SS.Points.PlayerUpdateGUI", "PlayerUpdateGUI", SS.Points.PlayerUpdateGUI)

// PlayerSetVariables

function SS.Points.PlayerSetVariables(Player)
	CVAR.New(Player, "Points", SS.Config.Request("Points Starting") * SS.Config.Request("Points Given"), function() return SS.Config.Request("Points Name") end)
	CVAR.New(Player, "Timer", SS.Config.Request("Points Timer"), function() return SS.Config.Request("Points Name").." Timer" end)
end

// Hook into player set variables

SS.Hooks.Add("SS.Points.PlayerSetVariables", "PlayerSetVariables", SS.Points.PlayerSetVariables)

// ServerMinute hook

function SS.Points.Minute()
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		local Ready = V:IsPlayerReady()
		
		// Ready
		
		if (Ready) then
			CVAR.Update(V, "Timer", CVAR.Request(V, "Timer") - 1)
			
			// Timer
			
			if (CVAR.Request(V, "Timer") <= 0) then
				CVAR.Update(V, "Timer", SS.Config.Request("Points Timer"))
				
				// Locals
				
				local Message = SS.Config.Request("Points Message")
				local Amount = tostring(SS.Config.Request("Points Given"))
				
				// Replace
				
				Message = string.Replace(Message, "%N", SS.Config.Request("Points Name"))
				Message = string.Replace(Message, "%A", Amount)
				
				// Message
				
				SS.PlayerMessage(V, Message, 0)
				
				// Gain
				
				SS.Points.PlayerGain(V, SS.Config.Request("Points Given"))
			end
			
			// Save
			
			CVAR.Save(V)
		end
	end
end

// Hook into ServerMinute

SS.Hooks.Add("SS.Points.Minute", "ServerMinute", SS.Points.Minute)
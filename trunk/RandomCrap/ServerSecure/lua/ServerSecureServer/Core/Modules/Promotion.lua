// Promotion

SS.Promotion        = {} // Promotion
SS.Promotion.List   = {} // Promotion list

// Add new promotion

function SS.Promotion.Add(Group, Hours)
	table.insert(SS.Promotion.List, {Group, Hours})
end

// ServerMinute hook

function SS.Promotion.Minute()
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		local Ready = V:IsPlayerReady()
		
		// Ready
		
		if (Ready) then
			// Update
			
			CVAR.Update(V, "Minutes Played", CVAR.Request(V, "Minutes Played") + 1)
			
			// Check
			
			if (CVAR.Request(V, "Minutes Played") >= 60) then
				// Update
				
				CVAR.Update(V, "Minutes Played", 0)
				CVAR.Update(V, "Hours Played", CVAR.Request(V, "Hours Played") + 1)
				
				// Check
				
				SS.Promotion.Check(V)
			end
		end
	end
end

// Hook into server minute

SS.Hooks.Add("SS.Promotion.Minute", "ServerMinute", SS.Promotion.Minute)

// PlayerSetVariables hook

function SS.Promotion.PlayerSetVariables(Player)
	CVAR.New(Player, "Hours Played", 0)
	CVAR.New(Player, "Minutes Played", 0)
end

// Hook into player set variables

SS.Hooks.Add("SS.Promotion.PlayerSetVariables", "PlayerSetVariables", SS.Promotion.PlayerSetVariables)

// PlayerUpdateGUI hook

function SS.Promotion.PlayerUpdateGUI(Player)
	Player:SetNetworkedString("Time Played", string.format("Time Played: %02d:%02d", CVAR.Request(Player, "Hours Played"), CVAR.Request(Player, "Minutes Played")))
end

// Hook into player update gui

SS.Hooks.Add("SS.Promotion.PlayerUpdateGUI", "PlayerUpdateGUI", SS.Promotion.PlayerUpdateGUI)

// Check

function SS.Promotion.Check(Player)
	local Group = false
	
	// Loop
	
	for K, V in pairs(SS.Promotion.List) do
		if (SS.Groups.GetGroupExists(V[1])) then
			if (CVAR.Request(Player, "Hours Played") >= V[2]) then
				if (SS.Groups.GetGroupRank(SS.Player.Rank(Player)) > SS.Groups.GetGroupRank(V[1])) then
					if (!Group or V[2] > Group[2]) then
						Group = {V[1], V[2]}
					end
				end
			end
		end
	end
	
	// Set to new group
	
	if (Group) then
		SS.PlayerMessage(0, Player:Name().." has been promoted to "..Group[1].."!", 0)
		
		// Change
		
		SS.Groups.Change(Player, Group[1])
		
		// Panel
		
		local Panel = SS.Panel:New(Player, "Promotion")
		
		// Words
		
		Panel:Words([[
			You've been promoted to ]]..Group[1]..[[!
			If you would like to find information about this group then you can do ]]..SS.ChatCommands.Prefix()..[[groups
			If you wish to see new commands that you can do just type ]]..SS.ChatCommands.Prefix()..[[commands!
		]])
		
		// Sends
		
		Panel:Send()
	end
end
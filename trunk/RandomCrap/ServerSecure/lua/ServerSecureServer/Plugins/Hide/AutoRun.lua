// Hide

local Plugin = SS.Plugins:New("Hide")

// When players values get set

function Plugin.PlayerSetVariables(Player)
	CVAR.New(Player, "Hidden", false)
end

// Chat command

local Hide = SS.ChatCommands:New("Hide")

function Hide.Command(Player, Args)
	local Bool = SS.Lib.StringBoolean(Args[1])
	
	// Update
	
	CVAR.Update(Player, "Hidden", Bool)

	// Messages
	
	if (Bool) then
		SS.PlayerMessage(Player, "You will be hidden when you next spawn!", 0)
	else
		SS.PlayerMessage(Player, "You no longer hidden!", 0)
	end
end

Hide:Create(Hide.Command, {"Server", "Hide"}, "Hide/Unhide", "<1|0>", 1, " ")

// Player spawn

function Plugin.PlayerSpawn(Player)
	timer.Create("Hide: PlayerSpawn", 0.5, 1,
	
	function(Player)
		if (CVAR.Request(Player, "Hidden")) then
			Player:HideServerSecureGUI("Hidden", "Hover", true)
		else
			Player:HideServerSecureGUI("Hidden", "Hover", false)
		end
	end,
	
	Player)
end

// Player choose model

function Plugin.PlayerChooseModel(Player)
	timer.Create("Hide: PlayerChooseModel", 0.5, 1,
	
	function(Player)
		if (CVAR.Request(Player, "Hidden")) then
			for K, V in pairs(SS.Groups.List) do
				if (V[7]) then
					if (V[4] != "") then
						Player:SetModel(V[4])
					end
				end
			end
		end
	end,
	
	Player)
end

// Player choose team

function Plugin.PlayerChooseTeam(Player)
	timer.Create("Hide: PlayerChooseTeam", 0.5, 1,
	
	function(Player)
		if (CVAR.Request(Player, "Hidden")) then
			local Default = SS.Groups.GetGroupDefault()
			
			Player:SetTeam(SS.Groups.GetGroupIndex(Default))
		end
	end,
	
	Player)
end

// Adjust the find function

local Find = SS.Lib.Find

if (Find) then
	function SS.Lib.Find(String)
		local Player, Error = Find(String)
		
		// Player
		
		if (Player) then
			if (CVAR.Request(Player, "Hidden")) then
				return false, "This person is using a clientside modification that prevents this!"
			end
		end
		
		// Player and error
		
		return Player, Error
	end
end

// Create

Plugin:Create()
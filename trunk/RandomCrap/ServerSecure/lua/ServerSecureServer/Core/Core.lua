if (SERVER) then
	// Meta
	
	include("Meta.lua")
	
	// Player spawn
	
	function SS.Player.PlayerSpawn(Player)
		local Ready = Player:IsPlayerReady()
		
		if (Ready) then
			// Check existing rank
			
			if not (SS.Groups.GetGroupExists(SS.Player.Rank(Player))) then
				local Default = SS.Groups.GetGroupDefault()
				
				// Change group
				
				SS.Groups.Change(Player, Default)
			end
			
			// Users
			
			local Group = SS.Groups.GetGroupUserGroup(SS.Player.Rank(Player))
			
			// Set usergroup
			
			Player:SetUserGroup(Group)
			
			// Group teams
			
			if (SS.Config.Request("Group Teams")) then SS.Player.PlayerChooseTeam(Player) end
			
			// Timers
			
			timer.Create("SS.Player.PlayerUpdateGUI: "..Player:UniqueID(), 0.05, 1, SS.Player.PlayerUpdateGUI, Player)
			timer.Create("SS.Player.PlayerSpawnModel: "..Player:UniqueID(), 0.05, 1, SS.Player.PlayerSpawnModel, Player)
			timer.Create("SS.Player.PlayerSpawnWeapons: "..Player:UniqueID(), 0.05, 1, SS.Player.PlayerSpawnWeapons, Player)
			
			// Run hook
			
			SS.Hooks.Run("PlayerSpawn", Player)
		end
	end

	hook.Add("PlayerSpawn", "SS.Player.PlayerSpawn", SS.Player.PlayerSpawn)
	
	// Immune
	
	function SS.Player.Immune(Player, Person, Action)
		if (SS.Flags.PlayerHas(Person, "Immune")) then
			local Rank = {}
			
			// Compare ranks
			
			Rank[1] = SS.Groups.GetGroupRank(SS.Player.Rank(Player))
			Rank[2] = SS.Groups.GetGroupRank(SS.Player.Rank(Person))
			
			// Check rank
			
			if (Rank[1] <= Rank[2]) then return false end
			
			// Return the text
			
			if not (Action) then
				return "This action cannot be done to this player!"
			else
				return Action.." cannot be done to this player!"
			end
		end
		
		return false
	end
	
	// Player death
	
	function SS.Player.PlayerDeath(Player, Attacker, Damage)
		// Unfreeze
		
		Player:Freeze(false)
		
		// Extinguish
		
		Player:Extinguish()
		
		// Remove when killed
		
		if (TVAR.Request(Player, "DeleteOnDeath")) then
			for K, V in pairs(TVAR.Request(Player, "DeleteOnDeath")) do
				if (V) then
					local Valid = SS.Lib.Valid(V)
					
					// Valid
					
					if (Valid) then
						V:Remove()
					end
				end
			end
		end
		
		// Run hook
		
		SS.Hooks.Run("PlayerDeath", Player, Attacker, Damage)
	end
	
	hook.Add("DoPlayerDeath", "SS.Player.PlayerDeath", SS.Player.PlayerDeath)
	
	// Player connect
	
	function SS.Player.PlayerConnect(ID, Address, Steam)
		SS.Hooks.Run("PlayerConnect", ID, Address, Steam)
	end
	
	hook.Add("PlayerConnect", "SS.Player.PlayerConnect", SS.Player.PlayerConnect)
	
	// Prop spawned
	
	function SS.Player.PlayerPropSpawned(Player, Model, Entity)
		SS.Hooks.Run("PlayerPropSpawned", Player, Entity)
	end
	
	hook.Add("PlayerSpawnedProp", "SS.Player.PlayerPropSpawned", SS.Player.PlayerPropSpawned)
	
	// Key press
	
	function SS.Player.PlayerKeyPress(Player, Key)
		SS.Hooks.Run("PlayerKeyPress", Player, Key)
	end
	
	hook.Add("KeyPress", "SS.Player.PlayerKeyPress", SS.Player.PlayerKeyPress)
	
	// Player initial spawn
	
	function SS.Player.PlayerInitialSpawn(Player, Done)
		if not (Done) then
			timer.Create("SS.Player.PlayerInitialSpawn: "..Player:UniqueID(), 1, 1, SS.Player.PlayerInitialSpawn, Player, true)
		else
			// CVARS
			
			CVAR.Load(Player) CVAR.Create(Player) SS.Player.PlayerSetVariables(Player)
			
			// Run hook
			
			SS.Hooks.Run("PlayerInitialSpawn", Player)
			
			// Respawn the player
			
			Player:Spawn()
		end
	end
	
	hook.Add("PlayerInitialSpawn", "SS.Player.PlayerInitialSpawn", SS.Player.PlayerInitialSpawn)

	// Player set variables
	
	function SS.Player.PlayerSetVariables(Player)
		SS.Hooks.Run("PlayerSetVariables", Player)
	end
	
	// Shut down
	
	function SS.ShutDown()
		SS.Hooks.Run("ServerShutdown") SVAR.Save()
	end
	
	hook.Add("ShutDown", "SS.ShutDown", SS.ShutDown)

	// Player spawn model
	
	function SS.Player.PlayerSpawnModel(Player)
		if (SS.Config.Request("Group Models")) then
			for K, V in pairs(SS.Groups.List) do
				if (V[1] == SS.Player.Rank(Player)) then
					if (V[4] != "") then
						Player:SetModel(V[4])
					end
				end
			end
		end
		
		// Run hook
		
		SS.Hooks.Run("PlayerChooseModel", Player)
	end

	// Player spawn weapons
	
	function SS.Player.PlayerSpawnWeapons(Player)
		local Table = {}
		
		// Strip
		
		if (SS.Config.Request("Group Weapons")) then Player:StripWeapons() end
		
		// Default
		
		for K, V in pairs(SS.Lib.GetTable(SS.Config.Request("Default Weapons"))) do
			Player:Give(V)
			
			// Insert the weapon
			
			table.insert(Table, V)
		end
		
		// List
		
		for K, V in pairs(SS.Groups.List) do
			if (V[1] == SS.Player.Rank(Player)) then
				for B, J in pairs(SS.Lib.GetTable(V[5])) do
					Player:Give(J)
					
					// Insert the weapon
					
					table.insert(Table, J)
				end
			end
		end
		
		// Run hook
		
		SS.Hooks.Run("PlayerGivenWeapons", Player, Table)
	end
	
	// Initialize
	
	function SS.Initialize()
		SS.Hooks.Run("ServerLoad")
	end
	
	hook.Add("Initialize", "SS.Initialize", SS.Initialize)

	// Player choose team
	
	function SS.Player.PlayerChooseTeam(Player)
		// Team
		
		for K, V in pairs(SS.Groups.List) do
			if (SS.Player.Rank(Player) == V[1]) then
				Player:SetTeam(V[2])
			end
		end
		
		// Run hook
		
		SS.Hooks.Run("PlayerChooseTeam", Player)
	end

	// Player message
	
	function SS.PlayerMessage(Player, Text, Type)
		if not (SS.Config.Request("Messages Enabled")) then return end
		
		// Time
		
		local Time = RealTime()
		
		// Type
		
		Type = Type or 0
		
		// Length
		
		if (string.len(Text) > 100) then
			Text = string.sub(Text, 0, 100)
			
			Text = Text.."..."
		end
		
		// Check type
		
		if (Player != 0) then
			if (Player == SS.ConsoleCommands.Console) then
				Player:ChatPrint(SS.Config.Request("Adverts Prefix").." "..Text)
			else
				TVAR.New(Player, "PlayerMessage", Time)
				
				// Check if we can do another one
				
				if (TVAR.Request(Player, "PlayerMessage") <= Time) then
					if (SS.Config.Request("Messages Style") == "Hint") then
						umsg.Start("SS.PlayerMessage", Player)
							umsg.Short(Type)
							umsg.String(SS.Config.Request("Adverts Prefix").." "..Text)
						umsg.End()
					elseif (SS.Config.Request("Messages Style") == "Chat") then
						Player:PrintMessage(3, SS.Config.Request("Adverts Prefix").." "..Text)
					elseif (SS.Config.Request("Messages Style") == "Center") then
						Player:PrintMessage(4, SS.Config.Request("Adverts Prefix").." "..Text)
					end
					
					// Update
					
					TVAR.Update(Player, "PlayerMessage", Time + SS.Config.Request("Messages Delay"))
				else
					Player:PrintMessage(3, SS.Config.Request("Adverts Prefix").." "..Text)
				end
				
				// Print to console
				
				Player:PrintMessage(2, SS.Config.Request("Adverts Prefix").." "..Text.."\n")
			end
		else
			// Send message to all players
			
			local Players = player.GetAll()
			
			for K, V in pairs(Players) do
				SS.PlayerMessage(V, Text, Type)
			end
			
			// Print to console
			
			Msg(SS.Config.Request("Adverts Prefix").." "..Text.."\n")
			
			// Run hook
			
			SS.Hooks.Run("ServerMessage", Text)
		end
	end
	
	// Server ticker
	
	function SS.ServerTicker(Player, Message, Time)
		if (Player == 0) then
			local Players = player.GetAll()
			
			// Loop
			
			for K, V in pairs(Players) do
				SS.ServerTicker(V, Message, Time)
			end
			
			// Console message
			
			Msg(Message.."\n")
		else
			if (Player == SS.ConsoleCommands.Console) then
				Player:ChatPrint(Message)
			else
				umsg.Start("SS.ServerTicker", Player)
					umsg.String(Message)
					umsg.Short(Time)
				umsg.End()
				
				// Print message to console
				
				Player:PrintMessage(2, Message)
			end
		end
	end
	
	// Rank
	
	function SS.Player.Rank(Player)
		local Valid = Player:IsPlayer()
		
		// Check valid
		
		if (Player and Valid) then
			for K, V in pairs(SS.Groups.Loaded) do
				local Steam = Player:SteamID()
				
				// Check steam
				
				if (string.lower(Steam) == string.lower(K)) then
					return V
				end
			end
		else
			return SS.Groups.GetGroupID(1)
		end
		
		// Return the default group
		
		return SS.Groups.GetGroupDefault()
	end

	// Minutes
	
	function SS.Minutes()
		SS.Hooks.Run("ServerMinute")
	end

	timer.Create("SS.Minutes", 60, 0, SS.Minutes)
	
	// Think
	
	function SS.Think()
		local Time = RealTime()
		
		// Tick
		
		SS.Tick = SS.Tick or 0
		
		// Tick check
		
		if (SS.Tick <= Time) then
			SS.Tick = Time + 1
			
			// Run hook
			
			SS.Hooks.Run("ServerSecond")
		end
		
		// Run hook
		
		SS.Hooks.Run("ServerThink")
	end
	
	hook.Add("Think", "SS.Think", SS.Think)
	
	// Player updated GUI
	
	function SS.Player.PlayerUpdateGUI(Player)
		if not (Player:IsPlayerReady()) then return end
		
		// Networked variables
		
		Player:SetNetworkedString("Group", "Group: "..SS.Player.Rank(Player))
		
		// Run hook
		
		SS.Hooks.Run("PlayerUpdateGUI", Player)
	end

	// Player disconnected
	
	function SS.Player.PlayerDisconnect(Player)
		SS.Hooks.Run("PlayerDisconnect", Player)
		
		// Save CVARS
		
		CVAR.Save(Player)
	end

	hook.Add("PlayerDisconnected", "SS.Player.PlayerDisconnect", SS.Player.PlayerDisconnect)
	
	// Give SWEP
	
	function SS.Player.GiveSWEP(Player, Command, Args)
		if (!Args[1]) then return end
		
		// SWEP
		
		local SWEP = weapons.GetStored(Args[1])
		
		// Check if the SWEP exists
		
		if (!SWEP) then return end
		
		// Check if you need the SWEPS flag
		
		if (SS.Config.Request("SWEPS Flag")) then
			if not (SS.Flags.PlayerHas(Player, "SWEPS")) then
				SS.PlayerMessage(Player, "You need the 'SWEPS' flag to spawn this SWEP!", 1)
				
				// Return
				
				return
			end
			
			// SWEP admin
			
			if not (SS.Config.Request("SWEPS Flag Admin")) then
				if (!SWEP.Spawnable and !Player:IsAdmin()) then
					SS.PlayerMessage(Player, "You do not have access to spawn this SWEP!", 1)
					
					// Return
					
					return
				end
			end
		else
			if (!SWEP.Spawnable and !Player:IsAdmin()) then
				SS.PlayerMessage(Player, "You need to be an admin to spawn this SWEP!", 1)
				
				// Return
				
				return
			end
		end
		
		// Give the player the SWEP
		
		Player:Give(SWEP.Classname)
	end
	
	// Override SWEP
	
	function SS.Player.OverrideSWEP()
		concommand.Add("gm_giveswep", SS.Player.GiveSWEP)
	end
	
	// Add hook
	
	SS.Hooks.Add("SS.Player.OverrideSWEP", "ServerLoad", SS.Player.OverrideSWEP)
end
// Stats

local Plugin = SS.Plugins:New("Stats")

// When players variables are set

function Plugin.PlayerSetVariables(Player)
	CVAR.New(Player, "Visits", 0)
	CVAR.New(Player, "Bans", 0)
	CVAR.New(Player, "Total Time Banned", 0)
	CVAR.New(Player, "Previous Names", {})
	
	// Name
	
	Plugin.Name(Player)
end

// Track players name

function Plugin.Name(Player)
	local ID = Player:Name()
	
	// Request
	
	CVAR.Request(Player, "Previous Names")[ID] = ID
end

// When name changes

function Plugin.PlayerNameChanged(Player, Backup, New)
	CVAR.Request(Player, "Previous Names")[New] = New
end

// Stats command

local Stats = SS.ChatCommands:New("Stats")

function Stats.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Server Statistics")
	
	// Words
	
	Panel:Words("Total Visits: "..SVAR.Request("Visits"))
	Panel:Words("Total Sentances Spoken: "..SVAR.Request("Text Spoken"))
	Panel:Words("Total "..SS.Config.Request("Points Name").." Given: "..SVAR.Request("Points Given"))
	Panel:Words("Total Commands Entered: "..SVAR.Request("Commands"))
	Panel:Words("Total Server Shutdowns: "..SVAR.Request("Shutdowns"))
	Panel:Words("Total Player Spawns: "..SVAR.Request("Spawns"))
	Panel:Words("Total Players Killed: "..SVAR.Request("Killed"))
	Panel:Words("Total Props Spawned: "..SVAR.Request("Props Spawned"))
	Panel:Words("Total Bans Given: "..SVAR.Request("Bans"))
	
	// Send
	
	Panel:Send()
end

Stats:Create(Stats.Command, {"Basic"}, "View server statistics")

// When player is killed

function Plugin.PlayerDeath()
	SVAR.Update("Killed", SVAR.Request("Killed") + 1)
end

// When player spawns

function Plugin.PlayerSpawn()
	SVAR.Update("Spawns", SVAR.Request("Spawns") + 1)
end

// When player typed a command

function Plugin.PlayerTypedCommand()
	SVAR.Update("Commands", SVAR.Request("Commands") + 1)
end

// When player is given points

function Plugin.PlayerGivenPoints(Player, Amount)
	SVAR.Update("Points Given", SVAR.Request("Points Given") + Amount)
end

// When player says something

function Plugin.PlayerTypedText(Player, Text)
	SVAR.Update("Text Spoken", SVAR.Request("Text Spoken") + 1)
end

// When player initially spawns

function Plugin.PlayerInitialSpawn(Player)
	SVAR.Update("Visits", SVAR.Request("Visits") + 1)
	
	// CVAR
	
	CVAR.Update(Player, "Visits", CVAR.Request(Player, "Visits") + 1)
end

// When server shuts down

function Plugin.ServerShutdown()
	SVAR.Update("Shutdowns", SVAR.Request("Shutdowns") + 1)
end

// When player spawns a prop

function Plugin.PlayerPropSpawned()
	SVAR.Update("Props Spawned", SVAR.Request("Props Spawned") + 1)
end

// When a player is banned

function Plugin.PlayerBanned(Player, Time, Reason)
	SVAR.Update("Bans", SVAR.Request("Bans") + 1)
	
	// CVARS
	
	CVAR.Update(Player, "Bans", CVAR.Request(Player, "Bans") + 1)
	CVAR.Update(Player, "Total Time Banned", CVAR.Request(Player, "Total Time Banned") + Time)
end

// When servers loads

function Plugin.ServerLoad()
	SVAR.New("Bans", 0)
	SVAR.New("Props Spawned", 0)
	SVAR.New("Shutdowns", 0)
	SVAR.New("Visits", 0)
	SVAR.New("Text Spoken", 0)
	SVAR.New("Points Given", 0)
	SVAR.New("Commands", 0)
	SVAR.New("Spawns", 0)
	SVAR.New("Killed", 0)
end

// Create

Plugin:Create()
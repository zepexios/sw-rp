// Groups

SS.Groups = {} // Groups functions

// Variables

SS.Groups.List    = {} // Groups
SS.Groups.Loaded  = {} // Loaded
SS.Groups.Current = 0 // Current Index

// Add a group

function SS.Groups:New(ID)
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Settings
	
	Table.Settings           = {}
	Table.Settings.Name      = ID
	Table.Settings.Color     = Color(200, 200, 200, 255)
	Table.Settings.Weapons   = {}
	Table.Settings.Flags     = {}
	Table.Settings.Bool      = false
	Table.Settings.UserGroup = "user"
	Table.Settings.Model     = ""
	Table.Settings.Symbol    = ""
	
	// Return table
	
	return Table
end

// Color

function SS.Groups:SetGroupColor(R, G, B, A)
	self.Settings.Color = Color(R, G, B, A)
end

// User group

function SS.Groups:SetGroupUserGroup(Group)
	self.Settings.UserGroup = Group
end

// Symbol

function SS.Groups:SetGroupSymbol(Symbol)
	self.Settings.Symbol = Symbol
end

// Weapons

function SS.Groups:SetGroupWeapons(...)
	local Table = {}
	
	// Loop
	
	for I = 1, table.getn(arg) do
		Table[I] = arg[I]
	end
	
	// Set
	
	self.Settings.Weapons = Table
end

// Flags

function SS.Groups:SetGroupFlags(...)
	local Table = {}
	
	// Loop
	
	for I = 1, table.getn(arg) do
		Table[I] = arg[I]
	end
	
	// Set
	
	self.Settings.Flags = Table
end

// Default

function SS.Groups:SetGroupDefault()
	self.Settings.Bool = true
end

// Model

function SS.Groups:SetGroupModel(Model)
	self.Settings.Model = Model
end

// Rank

function SS.Groups:SetGroupRank(Rank)
	self.Settings.Rank = Rank
end

// Finish

function SS.Groups:Create()
	SS.Groups.Current = SS.Groups.Current + 1
	
	// Rank
	
	if not (self.Settings.Rank) then
		SS.Lib.Error("No rank specified for group '"..self.Settings.Name.."'!")
	else
		table.insert(SS.Groups.List, {self.Settings.Name, SS.Groups.Current, self.Settings.Color, self.Settings.Model, self.Settings.Weapons, self.Settings.Rank, self.Settings.Bool, self.Settings.Flags, self.Settings.UserGroup, self.Settings.Symbol})
	end
end

// Insert steamid to be a group

function SS.Groups.InsertSteamID(Steam, Group)
	local Exists = SS.Groups.GetGroupExists(Group)
	
	// Check exists
	
	if not (Exists) then
		SS.Lib.Debug("Tried to insert "..Steam.." into "..Group.." which doesn't exist!")
	else
		SS.Groups.Loaded[Steam] = Group
	end
end

// See if group exists

function SS.Groups.GetGroupExists(ID)
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(V[1]) == string.lower(ID)) then
			return true
		end
	end
	
	// Return false
	
	return false
end

// Get group index by ID

function SS.Groups.GetGroupIndex(ID)
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(V[1]) == string.lower(ID)) then
			return V[2]
		end
	end
	
	// Return 0
	
	return 0
end

// Get user group by ID

function SS.Groups.GetGroupUserGroup(ID)
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(V[1]) == string.lower(ID)) then
			return V[9]
		end
	end
	
	return ""
end

// Get starting group

function SS.Groups.GetGroupDefault()
	for K, V in pairs(SS.Groups.List) do
		if (V[7]) then
			return V[1]
		end
	end
	
	// Return unknown
	
	return "Unknown"
end

// Find a group

function SS.Groups.Find(String)
	for K, V in pairs(SS.Groups.List) do
		if (string.find(string.lower(V[1]), string.lower(String))) then
			return V[1], "Found a match '"..V[1].."'"
		end
	end
	
	// Return false
	
	return false, "No matches found for '"..String.."'"
end

// Get group rank by ID

function SS.Groups.GetGroupRank(ID)
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(V[1]) == string.lower(ID)) then
			return V[6]
		end
	end
	
	// Return 0
	
	return 0
end

// Get group symbol by ID

function SS.Groups.GetGroupSymbol(ID)
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(V[1]) == string.lower(ID)) then
			return V[10]
		end
	end
	
	// Return nothing
	
	return ""
end

// Get group ID by rank

function SS.Groups.GetGroupID(Rank)
	for K, V in pairs(SS.Groups.List) do
		if (V[6] == Rank) then
			return V[1]
		end
	end
	
	// Return default group
	
	return SS.Groups.GetGroupDefault()
end

// PlayerInitialSpawn hook

function SS.Groups.Setup(Player)
	if (SS.Config.Request("Group Teams")) then
		local ID = Player:Name()
		
		// Debug
		
		SS.Lib.Debug("Sending groups to "..ID)
		
		// Loop
		
		for K, V in pairs(SS.Groups.List) do
			umsg.Start("SS.Groups.Setup", Player)
				umsg.String(V[1])
				umsg.String(V[10])
				umsg.Short(V[2])
				umsg.Short(V[3].r)
				umsg.Short(V[3].g)
				umsg.Short(V[3].b)
				umsg.Short(V[3].a)
				umsg.Short(V[6])
			umsg.End()
		end
	end
end

// Hook into player initial spawn

SS.Hooks.Add("SS.Groups.Setup", "PlayerInitialSpawn", SS.Groups.Setup)

// ServerLoad hook

function SS.Groups.Import()
	SS.Lib.Debug("Setting up and importing groups!")
	
	// Group teams
	
	if (SS.Config.Request("Group Teams")) then
		for K, V in pairs(SS.Groups.List) do
			team.SetUp(V[2], V[1], V[3])
		end
	end
	
	// Debug
	
	SS.Lib.Debug("Importing group data from Data/ServerSecure/Groups.txt!")
	
	// Exists
	
	if (file.Exists("ServerSecure/Groups.txt")) then
		local File = file.Read("ServerSecure/Groups.txt")
		
		// Loaded
		
		SS.Groups.Loaded = SS.Lib.KeyValuesToTable(File)
	else
		SS.Groups.Loaded = {}
	end
	
	// Add INI users

	local Parse = SS.Parser:New("lua/ServerSecureServer/Config/Users")

	// Exists
	
	local Exists = Parse:Exists()
	
	// Check exists
	
	if (Exists) then
		local Results = Parse:Parse()
		
		// Loop
		
		for K, V in pairs(Results) do
			for B, J in pairs(V) do
				SS.Groups.InsertSteamID(B, J)
			end
		end
	end
	
	// Write
	
	file.Write("ServerSecure/Groups.txt", SS.Lib.TableToKeyValues(SS.Groups.Loaded))
end

// Hook into server load

SS.Hooks.Add("SS.Groups.Import", "ServerLoad", SS.Groups.Import)

// Set players group

function SS.Groups.Change(Player, Group)
	local Steam = Player:SteamID()
	
	// Take group flags
	
	local Current = SS.Player.Rank(Player)
	
	// Take group flags
	
	SS.Flags.PlayerTakeGroupFlags(Player, Current)
	
	// Default
	
	local Default = SS.Groups.GetGroupDefault()
	
	// Set group
	
	if (Group == Default) then
		SS.Groups.Loaded[Steam] = nil
	else
		SS.Groups.Loaded[Steam] = Group
	end
	
	// Contents
	
	local Contents = SS.Lib.TableToKeyValues(SS.Groups.Loaded)
	
	// Write groups
	
	file.Write("ServerSecure/Groups.txt", Contents)
	
	// Respawn
	
	Player:Spawn()
	
	// Flags and purchases
	
	SS.Purchases.GiveFree(Player)
	SS.Flags.GiveFree(Player)
	
	// Run hook
	
	SS.Hooks.Run("PlayerChangedGroup", Player, Group)
end
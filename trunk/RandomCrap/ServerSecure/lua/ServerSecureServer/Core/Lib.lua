// Lib

SS.Lib = {} // Lib table

// Error message

function SS.Lib.Error(ID)
	local Message = string.upper("ERROR: "..ID)
	
	Msg("\n\n")
	
	Msg("// "..Message.."\n")
	
	Msg("\n\n")
end

// Debug message

function SS.Lib.Debug(Message)
	if (SS.Config.Request("Debug")) then
		Msg("[SS] Debug: "..Message.."\n")
	end
end

// Get table

function SS.Lib.GetTable(Table)
	local Type = type(Table)
	
	// Check type
	
	if (Type != "table") then Table = {Table} end
	
	// Return new
	
	return Table
	
end

// Add cs lua folder

function SS.Lib.AddCSLuaFolder(Folder)
	local Files = file.FindInLua(Folder.."*")
	
	// Files
	
	if (Files) then
		for K, V in pairs(Files) do
			if (V != "." and V != "..") then
				if (file.IsDir("../lua/"..Folder..V.."/")) then
					SS.Lib.AddCSLuaFolder(Folder..V.."/")
				else
					local Explode = string.Explode(".", V)
					
					// Number
					
					local Number = table.getn(Explode)
					
					// Extension
					
					local Extension = Explode[Number]
					
					// Check extension
					
					if (Extension == "lua") then
						AddCSLuaFile(Folder..V)
					end
				end
			end
		end
	end
end

// Table to key values

function SS.Lib.TableToKeyValues(Table)
	local function Convert(Table, Converted, New)
		// Converted
		
		Converted = Converted or {}
		
		// New
		
		New = New or {}
		
		// Core
		
		for K, V in pairs(Table) do
			if (type(V) == "table" and not Converted[K]) then
				Converted[K] = true
				
				// New
				
				New[SS.Lib.CaseProtect(K)] = Convert(V, Converted)
			else
				if not (Converted[K]) then
					Converted[K] = true
					
					// Type
					
					if (type(V) == "boolean") then
						V = "B"..tostring(V)
					elseif (type(V) == "Vector") then
						V = "V"..V.x.." "..V.y.." "..V.z
					elseif (type(V) == "Angle") then
						V = "A"..V.p.." "..V.y.." "..V.r
					elseif (type(V) == "number") then
						V = "N"..tostring(V)
					elseif (type(V) == "string") then
						V = "S"..tostring(V)
					end
					
					// New
					
					New[SS.Lib.CaseProtect(K)] = V
				end
			end
		end
		
		// New
		
		return New
	end
	
	// Return
	
	local Return = Convert(Table)
	
	// Return
	
	return util.TableToKeyValues(Return)
end

// Key values to table

function SS.Lib.KeyValuesToTable(String)
	local function Convert(Table, Converted, New)
		// Converted
		
		Converted = Converted or {}
		
		// New
		
		New = New or {}
		
		// Core
		
		for K, V in pairs(Table) do
			if (type(V) == "table" and not Converted[K]) then
				Converted[K] = true
				
				// New
				
				New[SS.Lib.CaseUnprotect(K)] = Convert(V, Converted)
			else
				if not (Converted[K]) then
					Converted[K] = true
					
					// Sub
					
					if (string.sub(V, 0, 1) == "B") then
						V = string.sub(V, 2)
						
						// Boolean
						
						if (V == "true") then V = true end
						if (V == "false") then V = false end
					elseif (string.sub(V, 0, 1) == "V") then
						V = string.sub(V, 2)
						
						// Explode
						
						local Explode = string.Explode(" ", V)
						
						// Number
						
						Explode[1] = tonumber(Explode[1])
						Explode[2] = tonumber(Explode[2])
						Explode[3] = tonumber(Explode[3])
						
						// Vector
						
						V = Vector(Explode[1], Explode[2], Explode[3])
					elseif (string.sub(V, 0, 1) == "A") then
						V = string.sub(V, 2)
						
						// Explode
						
						local Explode = string.Explode(" ", V)
						
						// Number
						
						Explode[1] = tonumber(Explode[1])
						Explode[2] = tonumber(Explode[2])
						Explode[3] = tonumber(Explode[3])
						
						// Angle
						
						V = Angle(Explode[1], Explode[2], Explode[3])
					elseif (string.sub(V, 0, 1) == "N") then
						V = string.sub(V, 2)
						
						// Number
						
						V = tonumber(V)
					elseif (string.sub(V, 0, 1) == "S") then
						V = string.sub(V, 2)
					end
					
					// New
					
					New[SS.Lib.CaseUnprotect(K)] = V
				end
			end
		end
		
		// New
		
		return New
	end
	
	// Table
	
	local Table = util.KeyValuesToTable(String)
	
	// Return
	
	local Return = Convert(Table)
	
	// Return
	
	return Return
end

// Case protect (Thanks to Tad2020)

function SS.Lib.CaseProtect(String)
	local New = ""
	
	// Numeric
	
	if (type(String) == "number") then return "#"..tostring(String) end
	
	// Fix
	
	for I = 1, string.len(String) do
		local Character = string.sub(String, I, I)
		
		// Character
		
		if (Character != string.lower(Character)) then Character = "^"..Character end
		
		// New
		
		New = New..Character
	end
	
	// New
	
	return New
end

// Case unprotect (Thanks to Tad2020)

function SS.Lib.CaseUnprotect(String)
	local New = ""
	
	// Numeric
	
	if (string.sub(String, 1, 1) == "#") then return tonumber(string.sub(String, 2)) end
	
	// Fix
	
	for I = 1, string.len(String) do
		local Character = string.sub(String, I, I)
		
		// Character
		
		if (string.sub(String, I - 1, I - 1) == "^") then Character = string.upper(Character) end
		
		// Carrot
		
		if (Character != "^") then New = New..Character end
	end
	
	// New
	
	return New
end

// Format

function SS.Lib.StringValue(String)
	local Type = type(String)
	
	// String
	
	if not (Type == "string") then return String end
	
	// Number
	
	local Number = tonumber(String)
	
	// Number
	
	if (Number) then return Number end
	
	// Boolean
	
	if (string.lower(String) == "false") then return false end
	if (string.lower(String) == "true") then return true end
	
	// String
	
	return String
end

// Smoke trail

function SS.Lib.CreateSmokeTrail(Entity, Col)
	local Table = {"sprites/firetrail.spr", "sprites/whitepuff.spr"}
	
	// Smoke
	
	local Smoke = ents.Create("env_smoketrail")
	
	// Key values
	
	Smoke:SetKeyValue("opacity", 1)
	Smoke:SetKeyValue("spawnrate", 25)
	Smoke:SetKeyValue("lifetime", 2)
	Smoke:SetKeyValue("startcolor", Col[1])
	Smoke:SetKeyValue("endcolor", Col[2])
	Smoke:SetKeyValue("minspeed", 15)
	Smoke:SetKeyValue("maxspeed", 30)
	Smoke:SetKeyValue("startsize", (Entity:BoundingRadius() / 2))
	Smoke:SetKeyValue("endsize", Entity:BoundingRadius())
	Smoke:SetKeyValue("spawnradius", 10)
	Smoke:SetKeyValue("emittime", 300)
	Smoke:SetKeyValue("firesprite", Table[1])
	Smoke:SetKeyValue("smokesprite", Table[2])
	Smoke:SetPos(Entity:GetPos())
	Smoke:SetParent(Entity)
	Smoke:Spawn()
	Smoke:Activate()
	
	// Delete on remove
	
	Entity:DeleteOnRemove(Smoke)
	
	// Smoke
	
	return Smoke
end

// Boolean value

function SS.Lib.StringBoolean(String)
	local Bool = true
	
	// Boolean
	
	if (string.lower(String) == "false") or (String == 0) then
		Bool = false
	end
	
	// Return
	
	return Bool
end

// Needed for votes etc

function SS.Lib.VotesNeeded(Number)
	local Fraction = SS.Lib.PlayersConnected() - (SS.Lib.PlayersConnected() / 4)
	
	// Fraction
	
	Fraction = math.floor(Fraction)
	Fraction = math.max(Fraction, 0)
	
	// Check
	
	if (Number < Fraction) then
		return false, Fraction
	end
	
	// Return
	
	return true, Fraction
end

// Random string

function SS.Lib.StringRandom(Characters)
	local String = ""
	
	// Loop
	
	for I = 1, Characters do
		String = String..string.char(math.random(48, 90))
	end
	
	// String
	
	String = string.upper(String)
	
	// Return
	
	return String
end

// Modified string.Replace

function SS.Lib.StringReplace(String, Find, Replace, Amount)
	local Start = 1
	
	// Done
	local Done = 0
	
	// Amount
	
	Amount = Amount or 0
	
	// Loop
	
	while (true) do
		local Pos = string.find(String, Find, Start, true)
		
		// Pos
		
		if (!Pos) then
			break
		end
		
		// Check
		
		if (Done == Amount and Amount != 0) then
			break
		end
		
		// Locals
		
		local L = string.sub(String, 1, Pos - 1)
		local R = string.sub(String, Pos + #Find)
		
		// String
		
		String = L..Replace..R
		
		// Start
		
		Start = Pos + #Replace
		
		// Done
		
		Done = Done + 1
	end
	
	// Return
	
	return String
end

// Chop string

function SS.Lib.StringChop(String, Amount)
	local Pieces = {}
	local Current = 0
	
	// While
	
	while (string.len(String) > Amount) do
		local Text = string.sub(String, Current, Amount)
		
		// Insert
		
		table.insert(Pieces, Text)
		
		// String
		
		String = string.sub(String, Amount)
	end
	
	// Return
	
	return Pieces
end

// Blowup

function SS.Lib.EntityExplode(Entity)
	// Effect data
	
	local Effect = EffectData()
	
	// Effect settings
	
	Effect:SetOrigin(Entity:GetPos())
	Effect:SetScale(1)
	Effect:SetMagnitude(25)
	
	// Effect
	
	util.Effect("Explosion", Effect, true, true)

	// Kill
	
	local Player = Entity:IsPlayer()
	
	// Player
	
	if (Player) then
		Entity:Kill()
	else
		Entity:Remove()
	end
end

// Explode string

function SS.Lib.StringExplode(String, Seperator)
	local Table = string.Explode(Seperator, String)
	
	// Loop
	
	for K, V in pairs(Table) do
		Table[K] = string.Trim(V)
		
		// Check
		
		if (V == "") then
			Table[K] = nil
		end
	end
	
	// Table
	
	return Table
end

// To number

function SS.Lib.StringNumber(String)
	return tonumber(String)
end

// Get string color like 255, 255, 255, 255

function SS.Lib.StringColor(String)
	local Explode = SS.Lib.StringExplode(String, ", ")
	
	// Local
	
	local R = tonumber(Explode[1]) or 0
	local G = tonumber(Explode[2]) or 0
	local B = tonumber(Explode[3]) or 0
	local A = tonumber(Explode[4]) or 0
	
	// Return
	
	return Color(R, G, B, A)
end

// Players connected

function SS.Lib.PlayersConnected()
	local Players = player.GetAll()
	
	// Return
	
	return table.Count(Players)
end

// Random table entry

function SS.Lib.RandomTableEntry(Table)
	local Max = math.random(1, table.getn(Table))	
	local Type = Table[Max]
	
	// Type
	
	if (Type == "table") then
		return SS.Lib.RandomTableEntry(Table[Max])
	end
	
	// Return
	
	return Table[Max]
end

// Find player from a string or user ID

function SS.Lib.Find(String)
	if (type(String) != "number") then
		String = string.lower(String)
	end
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		if (type(String) == "number") then
			if (V:UserID() == String) then
				return V, "Match found for "..String.."!"
			end
		end
		
		// ID
		
		local ID = V:Name()
		
		// ID
		
		ID = string.lower(ID)
		
		// Find
		
		if (string.find(ID, String)) then
			return V, "Match found for "..String.."!"
		end
	end
	
	// Return
	
	return false, "There was no matches for "..String.."!"
end

// Add all custom content in a folder

function SS.Lib.AddCustomContent(Folder)
	local Files = file.Find("../"..Folder.."*")
	
	// Files
	
	if (Files) then
		for K, V in pairs(Files) do
			if (file.IsDir("../"..Folder..V.."/")) then
				SS.Lib.AddCustomContent(Folder..V.."/")
			else
				if (V != "." and V != "..") then
					resource.AddFile(Folder..V)
				end
			end
		end
	end
end

// Include all files in a folder and include

function SS.Lib.IncludeFolder(Folder, Extension)
	local Files = file.Find("../lua/"..Folder.."*"..Extension)
	
	// Message
	
	Msg("\n")
	
	// Loop
	
	for K, V in pairs(Files) do
		include(Folder..V)
		
		// Message
		
		Msg("\n\t[Generic] File - "..V.." loaded")
	end
	
	// Message
	
	Msg("\n")
end

// Find all files in folders in a folder and include

function SS.Lib.FolderIncludeFolders(Folder, Extension)
	local Files = file.Find("../lua/"..Folder.."*")
	
	// Message
	
	Msg("\n")
	
	// Loop
	
	for K, V in pairs(Files) do
		local Friendly = V
		
		// Add
		
		V = V.."/"
		
		// Is directory
		
		if (file.IsDir("../lua/"..Folder..V)) then
			local Temp = file.Find("../lua/"..Folder..V.."*"..Extension)
			
			// Loop
			
			for B, J in pairs(Temp) do
				include(Folder..V..J)
				
				// Message
				
				Msg("\n\t["..Friendly.."] File - "..J.." loaded")
			end
		end
	end
end

// Execute serverside console command

function SS.Lib.ConCommand(Key, ...)
	local Table = {}
	
	// Loop
	
	if (arg) then
		for I = 1, table.getn(arg) do
			Table[I] = arg[I]
		end
	end
	
	// Value
	
	local Value = table.concat(Table, " ")
	
	// Console command
	
	game.ConsoleCommand(Key..' '..Value..'\n')
end

// Kick a player

function SS.Lib.PlayerKick(Player, Reason)	
	local Steam = Player:SteamID()
	
	// Console command
	
	SS.Lib.ConCommand("kickid", Steam, Reason)
end

// Ban player

function SS.Lib.PlayerBan(Player, Time, Reason, Announce)
	// Nils
	
	Reason = Reason or "<None Specified>"
	
	// Run hook before banned
	
	SS.Hooks.Run("PlayerBanned", Player, Time, Reason)
	
	// Ban
	
	local Steam = Player:SteamID()
	
	// Console command
	
	SS.Lib.ConCommand("banid", Time, Steam)
	
	// Send ban GUI
	
	umsg.Start("SS.Ban", Player)
		umsg.String(Reason)
		umsg.Short(Time)
	umsg.End()
	
	// Kick
	
	timer.Simple(10, SS.Lib.ConCommand, "kickid", Steam, "Banned")
	timer.Simple(10, SS.Lib.ConCommand, "writeid")
	
	// Announce
	
	if (Announce) then
		local Seconds = Time * 60
		local Formatted = string.FormattedTime(Seconds)
		
		// Time
		
		if (Time > 60) then
			Formatted.h = math.floor(Formatted.h)
			Formatted.m = math.Clamp(Formatted.m, 0, 60)
			
			// Message
			
			SS.PlayerMessage(0, Player:Name().." has been banned for "..Formatted.h.." hours and "..Formatted.m.." minutes ("..Reason..")!", 0)
		else
			if (Time == 0) then
				SS.PlayerMessage(0, Player:Name().." has been banned permanently ("..Reason..")!", 0)
			else
				SS.PlayerMessage(0, Player:Name().." has been banned for "..Time.." minutes ("..Reason..")!", 0)
			end
		end
	end
	
	// Freeze
	
	Player:Freeze(true)
end

// Slay player

function SS.Lib.PlayerSlay(Player)
	Player:Kill()
end

// Freeze player

function SS.Lib.PlayerFreeze(Player, Bool)
	if (Bool) then
		Player:Freeze(true)
	else
		Player:Freeze(false)
	end
end

// Ignite player

function SS.Lib.PlayerIgnite(Player, Bool)
	if (Bool) then
		Player:Ignite(60, 0)
	else
		Player:Extinguish()
	end
end

// Blind player

function SS.Lib.PlayerBlind(Player, Bool)
	umsg.Start("SS.Blind", Player) umsg.Bool(Bool) umsg.End()
end

// God player

function SS.Lib.PlayerGod(Player, Bool)
	if (Bool) then
		Player:GodEnable()
	else
		Player:GodDisable()
	end
end

// Invis player

function SS.Lib.PlayerInvis(Player, Bool)
	Player:HideServerSecureGUI("Invis", "Hover", Bool)
	Player:HideServerSecureGUI("Invis", "Name", Bool)
	
	// Bool
	
	if not (Bool) then
		Player:SetMaterial("")
		Player:DrawWorldModel(true)
	else
		Player:SetMaterial("sprites/heatwave")
		Player:DrawWorldModel(false)
	end
end

// Valid entity

function SS.Lib.Valid(Entity)
	if not (Entity) then return false end
	
	// Valid
	
	local Valid = Entity:IsValid()
	
	// Check valid
	
	if (Valid) then
		return true
	end
	
	// return
	
	return false
end
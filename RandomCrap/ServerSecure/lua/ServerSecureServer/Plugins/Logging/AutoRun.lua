// Logging

local Plugin = SS.Plugins:New("Logging")

// Add entry

function Plugin.Add(Text)
	local Date = string.gsub(os.date("%x"), "/", "-")
	
	// File
	
	local File = "ServerSecure/Logs/"..Date..".txt"
	local Prev = ""
	
	// Text
	
	Text = "("..os.date("%X")..") "..Text
	
	// Exists
	
	if (file.Exists(File)) then
		Prev = file.Read(File)
	end
	
	// Concatenate
	
	Prev = Prev..Text.."\n"
	
	// Write
	
	file.Write(File, Prev)
end

// Begin

function Plugin.ServerLoad()
	Plugin.Add("[ New Session: "..game.GetMap().." ]")
end

// End

function Plugin.ServerShutdown()
	Plugin.Add("[ End Session ]")
end

// Player initial spawn

function Plugin.PlayerInitialSpawn(Player)
	Plugin.Add("["..Player:SteamID().."] ["..Player:IPAddress().."] "..Player:Name().." has connected!")
end

// Player command

function Plugin.PlayerTypedCommand(Player, Command, Args)
	local Args = table.concat(Args, " ")
	
	// Add text
	
	Plugin.Add("["..Player:SteamID().."] "..Player:Name().." entered the command "..Command.." "..Args.."!")
end

// Player concommand

function Plugin.PlayerConsoleCommand(Player, Command, Args)
	local Args = table.concat(Args, " ")
	
	// Add text
	
	Plugin.Add("["..Player:SteamID().."] "..Player:Name().." entered the console command "..Command.." "..Args.."!")
end

// Player typed something

function Plugin.PlayerTypedText(Player, Text)
	Plugin.Add("["..Player:SteamID().."] "..Player:Name()..": "..Text)
end

// Player spawned a prop

function Plugin.PlayerPropSpawned(Player, Entity)
	Plugin.Add("["..Player:SteamID().."] "..Player:Name().." spawned an entity "..Entity:GetClass().."!")
end

// Player killed

function Plugin.PlayerKilled(Player, Killer)
	local Text = ""
	
	// Killer is player
	
	if (Killer:IsPlayer()) then
		Text = Killer:Name().." ("..Killer:SteamID()..")"
	else
		if (SS.Lib.Valid(Killer)) then
			Text = Killer:GetClass()
		end
	end
	
	// Add text
	
	Plugin.Add("["..Player:SteamID().."] "..Player:Name().." was killed by "..Text)
end

// Message to all

function Plugin.ServerMessage(Text)
	Plugin.Add(Text)
end

// Create

Plugin:Create()
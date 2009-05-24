// AFK

local Plugin = SS.Plugins:New("AFK")

// Time

Plugin.Time = 120 // Time idle to be put into AFK mode

// When players values get set

function Plugin.PlayerSetVariables(Player)
	TVAR.New(Player, "AFK", "")
	
	// Reset
	
	Plugin.Reset(Player)
end

// AFK

function Plugin.AFK(Player)
	if (Player and Player:IsConnected()) then
		TVAR.Update(Player, "AFK", "AFK")
		
		// Usermessage
		
		umsg.Start("SS.AFK", Player)
			umsg.Bool(true)
		umsg.End()
		
		// GUI
		
		SS.Player.PlayerUpdateGUI(Player)
		
		// Message
		
		SS.PlayerMessage(Player, "You are now AFK!", 0)
	end
end

// Reset

function Plugin.Reset(Player)
	if (TVAR.Request(Player, "AFK") == "AFK") then
		// Usermessage
		
		umsg.Start("SS.AFK", Player)
			umsg.Bool(false)
		umsg.End()
		
		// Variable
		
		TVAR.Update(Player, "AFK", "")
		
		// Message
		
		SS.Player.PlayerUpdateGUI(Player)
	end
	
	// Timer
	
	timer.Create("AFK: "..Player:UniqueID(), Plugin.Time, 1, Plugin.AFK, Player)
end

// When players GUI is updated

function Plugin.PlayerUpdateGUI(Player)
	Player:SetNetworkedString("AFK", TVAR.Request(Player, "afk"))
end

// Chat command

local AFK = SS.ChatCommands:New("AFK")

function AFK.Command(Player, Args)
	if (TVAR.Request(Player, "AFK") == "AFK") then
		SS.PlayerMessage(Player, "Your status is already set to AFK!", 1)
		
		// Return false
		
		return false
	end
	
	// Set AFK
	
	Plugin.AFK(Player)
end

AFK:Create(AFK.Command, {"Basic"}, "Set your status to AFK")

// Keypress

function Plugin.PlayerKeyPress(Player)
	Plugin.Reset(Player)
end

// Finish plugin

Plugin:Create()

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."AFK if you are going away for a while!")
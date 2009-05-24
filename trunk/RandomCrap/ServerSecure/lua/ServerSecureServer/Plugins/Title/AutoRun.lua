// Title

local Plugin = SS.Plugins:New("Title")

// When players values get set

function Plugin.PlayerSetVariables(Player)
	CVAR.New(Player, "Title", "")
end

// When players GUI is updated

function Plugin.PlayerUpdateGUI(Player)
	Player:SetNetworkedString("Title", CVAR.Request(Player, "Title"))
end

// Chat command

local Title = SS.ChatCommands:New("Title")

function Title.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Title
	
	local Title = table.concat(Args, " ", 2)
	
	// Check
	
	if (string.lower(Title) == "none") then
		Title = ""
	end
	
	// Check
	
	if (Person) then
		CVAR.Update(Person, "Title", Title)
		
		SS.PlayerMessage(Player, "You changed "..Person:Name().."'s Title!", 0)
		
		if (Player == Person) then return end
		
		SS.PlayerMessage(Person, Player:Name().." changed your Title to "..Title.."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

Title:Create(Title.Command, {"Administrator", "Title"}, "Set a specific player's Title", "<Player> <Title>", 2, " ")

// Create

Plugin:Create()
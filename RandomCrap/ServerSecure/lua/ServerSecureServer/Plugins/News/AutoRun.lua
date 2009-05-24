// News

local Plugin = SS.Plugins:New("News")

// Config

Plugin.News = "To set the news please type "..SS.ChatCommands.Prefix().."news <Text>"

// When a player initially spawns

function Plugin.PlayerInitialSpawn(Player)
	Plugin.Show(Player)
end

// Show

function Plugin.Show(Player)
	local News = SVAR.Request("News")
	
	// Panel
	
	local Panel = SS.Panel:New(Player, "News and Rules")
	
	// Words
	
	Panel:Words(News)
	
	// Add rules to panel
	
	SS.Rules.AddToPanel(Panel)
	
	// Send
	
	Panel:Send()
end

// Chat command

local Command = SS.ChatCommands:New("News")

function Command.Command(Player, Args)
	local News = table.concat(Args, " ")
	
	// Update
	
	SVAR.Update("News", News)
	
	SS.PlayerMessage(Player, "The server news has been set to "..News.."!", 0)
	
	// Show all
	
	local Players = player.GetAll()
	
	for K, V in pairs(Players) do
		Plugin.Show(V)
	end
end

Command:Create(Command.Command, {"Server"}, "Set the news of the server", "<Text>", 1, " ")

// When servers loads

function Plugin.ServerLoad()
	SVAR.New("News", Plugin.News)
end

// Create

Plugin:Create()
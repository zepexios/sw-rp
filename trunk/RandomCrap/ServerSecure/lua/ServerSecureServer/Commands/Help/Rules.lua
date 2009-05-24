// Rules

local Rules = SS.ChatCommands:New("Rules")

// Rules

function Rules.Command(Player, Args)
	SS.Rules.Show(Player)
end

// Create it

Rules:Create(Rules.Command, {"Basic"}, "View the server rules")

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."rules to see the rules of the server!")
// The date

local TheDate = SS.ChatCommands:New("TheDate")

// The date

function TheDate.Command(Player, Args)
	SS.PlayerMessage(Player, "The date is "..os.date("%x")..".", 0)
end

TheDate:Create(TheDate.Command, {"Basic"}, "View the date")
// The time

local TheTime = SS.ChatCommands:New("TheTime")

// The time

function TheTime.Command(Player, Args)
	SS.PlayerMessage(Player, "The time is "..os.date("%X")..".", 0)
end
concommand.Add("TheTime", TheTime)
TheTime:Create(TheTime.Command, {"Basic"}, "View the time")
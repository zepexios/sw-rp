// Remember, price is what you set multiplied by the amount of points a player gets when his timer goes down
// You can also set a function to run when the player purchases it is you want

// Avatar

local function Avatar(Player)
	SS.PlayerMessage(Player, "Type "..SS.ChatCommands.Prefix().."avatar <URL> to set a custom avatar in the scoreboard!", 0)
end

SS.PurchaseFlags.Add("Avatar", "Flag [Avatar]", 10, "Set a custom avatar in the scoreboard", Avatar)
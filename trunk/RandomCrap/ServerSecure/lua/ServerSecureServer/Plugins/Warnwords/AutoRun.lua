// Warnwords

SS.Warnwords = SS.Plugins:New("Warnwords")

// Words

include("Config.lua")

// When player says something

function SS.Warnwords.PlayerTypedText(Player, Text)
	for K, V in pairs(SS.Warnwords.List) do
		if (string.find(string.lower(Text), string.lower(V))) then
			SS.Warnings.Warn(Player, 1, "Warnword: "..V)
			
			// Text return

			local Backup = Player:GetTextReturn()
			
			if not (Backup) then
				Player:SetTextReturn(Text, 4)
			end
			
			// Break
			
			break
		end
	end
end

// Create

SS.Warnwords:Create()
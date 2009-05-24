// Filter

SS.Filter = SS.Plugins:New("Filter")

// Words

include("Config.lua")

// When player says something

function SS.Filter.PlayerTypedText(Player, Text)
	Text = string.gsub(Text, "(.+)", " %1 ")
	
	// Filter words
	
	for K, V in pairs(SS.Filter.Words) do
		Text = string.gsub(Text, "(%s)"..V[1].."(%s)", "%1"..V[2].."%1")
	end
	
	// Capital
	
	local Capital = string.sub(Text, 0, 2)
	
	// Higher
	
	local Higher = string.upper(Capital)
	
	// Text
	
	Text = SS.Lib.StringReplace(Text, Capital, Higher, 1)
	
	// Punctuation
	
	Text = string.sub(Text, 2, -2)
	
	// Cannot find punctuation
	
	if not (string.find(string.sub(Text, -1), "%p")) then
		Text = Text.."."
	end
	
	// Text return
	
	local Backup = Player:GetTextReturn()
	
	// Not backup
	
	if not (Backup) then
		Player:SetTextReturn(Text, 4)
	end
end

// Create

SS.Filter:Create()
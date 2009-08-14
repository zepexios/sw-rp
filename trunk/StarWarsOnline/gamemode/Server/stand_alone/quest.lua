
//Used for storing the needed information on the player
SWO.createQuestData = function(name, st)
	local quest = {}
	item["name"] = name
	item.start = st or false
	item.fin = false
	return quest
end

//Used as the universal copy of the quest from which most data is checked
//TODO
SWO.createItem = function()

end
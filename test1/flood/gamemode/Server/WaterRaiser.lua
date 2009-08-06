-----------------------------
-- Flood By iRzilla
-----------------------------
-- Server/WaterRaiser.lua

FL.WaterIs = 0

function FL.ToggleWater()
	for k, v in pairs(ents.FindByName("water")) do
		if FL.WaterIs == 0 then
			v:Fire("Open","",0)
			FL.WaterIs = 1
		else
			v:Fire("Close","",0)
			FL.WaterIs = 0
		end
	end
end
// HUDDrawTargetID

function gamemode:HUDDrawTargetID()
	if (!SS.Config.Request("Show Hover Information", "Boolean", true)) then
		return self.BaseClass:HUDDrawTargetID()
	end
end
local active = false

local function GUIMouse()
	if active then
		active = false
	else
		active = true
	end
	gui.EnableScreenClicker(active)
end

concommand.Add( "MouseInput", GUIMouse )
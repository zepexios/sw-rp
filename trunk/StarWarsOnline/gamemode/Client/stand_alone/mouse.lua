SWO.Mouse = {}
SWO.Mouse.Active = false


local function GUIMouse()
	if( SWO.Mouse.Active )then
		SWO.Mouse.Active = false
	else
		SWO.Mouse.Active = true
	end
	gui.EnableScreenClicker( SWO.Mouse.Active )
end
local function GUIMouseEnable()
	SWO.Mouse.Active = true
	gui.EnableScreenClicker( SWO.Mouse.Active )
	if( SWO.Mouse.LastPosX and SWO.Mouse.LastPosY ) then
		gui.SetMousePos( SWO.Mouse.LastPosX, SWO.Mouse.LastPosY )
	end
end
local function GUIMouseDisable()
	SWO.Mouse.Active = false
	SWO.Mouse.LastPosX, SWO.Mouse.LastPosY = gui.MousePos()
	gui.EnableScreenClicker( SWO.Mouse.Active )
end
concommand.Add( "MouseInput", GUIMouse )
concommand.Add( "+MouseInput", GUIMouseEnable )
concommand.Add( "-MouseInput", GUIMouseDisable )
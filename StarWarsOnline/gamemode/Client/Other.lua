function EnableGUIMouse()
	gui.EnableScreenClicker( true )
end
function DisableGUIMouse()
	gui.EnableScreenClicker( false )
end
concommand.Add( "+MouseInput", EnableGUIMouse )
concommand.Add( "+MouseInput", DisableGUIMouse )
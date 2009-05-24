function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)

function DrawHud()

	health = LocalPlayer():Health()
	draw.RoundedBox( 2, 3, 6, 300, 15, Color( 51, 50, 0, 150 ) )
	draw.RoundedBox( 2, 4, 7, health, 12, Color( 255, 0, 0, 255 ) )
	
end
hook.Add("HUDPaint", "DrawHud", DrawHud)

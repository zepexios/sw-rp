function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)

function myhud()
local client = LocalPlayer()
if !client:Alive() then return end
if (client:GetActiveWeapon() == NULL or client:GetActiveWeapon() == "Camera") then return end

draw.RoundedBox(3, 5, 5, 400, 300, Color(51, 58, 51, 255))
draw.SimpleText(client:Health() .. "%", "ScoreBoardText", 150, 100, Color(86, 104, 86, 255), 0, 0)
draw.SimpleText(ply:UniqueID() ("ScoreBoardText", 250, 200, Color(124, 252, 0, 255), 0, 0)

//if (ply:Team() == "jedi") then jedi is not made yet for future use
//draw.SimpleText(Client:Force() ("ScoreBoardText", 300, 250, Color(218, 112, 214, 255), 0, 0)  // not defined yet  

// just a base HUD until my friend jammie tells me how to create health boxes = D
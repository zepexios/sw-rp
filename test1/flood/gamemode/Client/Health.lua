-----------------------------
-- Flood By iRzilla
-----------------------------
-- Client/Health.lua

function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do 
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud) 


FL.HUD = {}

FL.HUD.Wide = ScrW()/5
FL.HUD.Tall = 24
FL.HUD.Space = 4

FL.HUD.MinWide = 4
FL.HUD.BlockWide = FL.HUD.Space + FL.HUD.Wide + FL.HUD.Space
FL.HUD.BlockTall = FL.HUD.Space + FL.HUD.Tall + FL.HUD.Space

surface.CreateFont("coolvetica",FL.HUD.Tall,400,true,false,"FL.HUD_Font")

function FL.HUD:Paint()
	if LocalPlayer():Alive() && LocalPlayer():IsValid() then
		draw.RoundedBox(4, 4, (ScrH() - (self.BlockTall*2) - self.Tall - self.Space), self.BlockWide, ((self.BlockTall*2) + self.Tall), Color(0,0,0,200))
	
		local HH = LocalPlayer():Health()
		local HF = math.Clamp(HH/100, 0, 1)
		local HW = (self.Wide - self.MinWide) * HF

		draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*3) - (self.Space*4)), self.MinWide + HW, self.Tall, Color(221,82,82,255))
		draw.SimpleText(math.Max(HH, 0).." HP","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall*2) - (self.Tall/2) - (self.Space*4)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)


		if ValidEntity(LocalPlayer():GetActiveWeapon()) then
			if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 || LocalPlayer():GetActiveWeapon():Clip1() > 0 then
				local CH = (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) + LocalPlayer():GetActiveWeapon():Clip1())
				local CF = math.Clamp(CH/100, 0, 1)
				local CW = ((self.Wide) - self.MinWide) * CF
				
				draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.MinWide + CW, self.Tall, Color(0,242,242,255))
				draw.SimpleText(CH.." Bullets","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.Wide, self.Tall, Color(0,242,242,255))
				draw.SimpleText("Ammo","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		else
			draw.RoundedBox(4, (self.Space*2), (ScrH() - (self.Tall*2) - (self.Space*3)), self.Wide, self.Tall, Color(0,242,242,255))
			draw.SimpleText("Ammo","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - self.Tall - (self.Tall/2) - (self.Space*3)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

		if LocalPlayer():GetCash() != nil && LocalPlayer():GetCash() != "" then
			local MH = LocalPlayer():GetCash()
			local MF = math.Clamp(MH / 5000, 0, self.Wide)
			local MW = (MF + 5)

			if MH < 750000 then
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), MW, self.Tall, Color(0,221,55,255))
				draw.SimpleText("$"..MH,"FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), MW, self.Tall, Color(0,221,55,255))
				draw.SimpleText("$"..MH.." OMG!?!","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		else
				draw.RoundedBox(4, (self.Space*2), ScrH() - self.Tall - (self.Space*2), self.Wide, self.Tall, Color(0,221,55,255))
				draw.SimpleText("Profile Loading...","FL.HUD_Font", self.Wide/2 + (self.Space*2), (ScrH() - (self.Tall/2) - (self.Space*2)), Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end

	end
end
hook.Add("HUDPaint","FL.HUD.Paint",function() FL.HUD:Paint() end)
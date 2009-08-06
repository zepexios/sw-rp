-----------------------------
-- Flood By iRzilla
-----------------------------
-- Client/NotifyBars.lua

FL.NotifyBars = {}
FL.NotifyBars.PANEL = {}
FL.NotifyBars.Strings = {}
local flash = 255

FL.NotifyBars.Strings[0] = "Press F1 To Open The Help Guide"
FL.NotifyBars.Strings[1] = "Round Time: 0:00"
FL.NotifyBars.Strings[2] = false

function FL.NotifyBars.PANEL.HudPaint()
	for k, v in pairs(FL.NotifyBars.Strings) do
		if v != false then 
		surface.SetFont("DefaultBold")
		local w, h = surface.GetTextSize(v)
		draw.RoundedBox( 4, ScrW()/2-w/2-10, k*h*2+5, w+20, h+10, Color(0, 0, 0, 200) )
		draw.SimpleText(v, "DefaultBold", ScrW()/2, k*h*2+10, Color(255,flash,flash,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint","FL.NotifyBars.LOLLOL",function() FL.NotifyBars.PANEL.HudPaint() end)

timer.Create("FL.NotifyBars.FTimer", 2, 0, function() if flash == 255 then flash = 0 else flash = 255 end end)
// Draw

SS.Draw = {}

// Cursor near bar

function SS.Draw.Cursor()
	local X, Y = gui.MousePos()
	
	// Check
	
	if (X > 0 and X < ScrW() and Y > 0 and Y < 24) then
		return true
	end
end

// Bar

function SS.Draw.Bar()
	// Hidden
	
	if (SS.Lib.Hidden(SS.Client, "Bar")) then return end
	
	// Cursor
	
	local Cursor = SS.Draw.Cursor()
	
	// Top bar disabled
	
	if not (SS.Config.Request("Enable Bar", "Boolean", true)) and not (Cursor) then
		surface.SetFont(SS.GUI.Font)
		
		local Text = "[ServerSecure]"
		
		// Width and height
		
		local W, H = surface.GetTextSize(Text)
		
		W = W + 16
		
		// Box
		
		draw.RoundedBox(4, 4, 4, W, 24, Color(50, 50, 50, 150))
		
		// Text
		
		SS.GUI.DrawShadowedText(Text, SS.GUI.Font, 4 + (W / 2), 4 + (24 / 2), Color(255, 255, 255, 255), 1, 1)
		
		// Return false
		
		return false
	end
	
	// Color
	
	local Col = SS.Lib.GetTeamColor()
	
	// Group color
	
	if not (SS.Config.Request("Enable Bar Group Color", "Boolean", true)) then
		Col = Color(255, 255, 255, 255)
	end
	
	// Ticker
	
	SS.ServerTicker.Draw(Col)
	
	// Data
	
	local Data = SS.Parts.Request(LocalPlayer(), "Bar")
	
	if (Data) then
		local Height = 24
		
		// Box
		
		draw.RoundedBox(0, 0, 0, ScrW(), Height, Color(50, 50, 50, 200))
		
		// Border
		
		draw.RoundedBox(0, 0, Height, ScrW(), 2, Col)
		
		// Text
		
		local Text = table.concat(Data, "\t")
		
		// Shadowed text
		
		SS.GUI.DrawShadowedText(Text, "Default", 5, 5, Color(255, 255, 255, 255), 0, 0)
	end
end

hook.Add("HUDDrawScoreBoard", "SS.Draw.Bar", SS.Draw.Bar)
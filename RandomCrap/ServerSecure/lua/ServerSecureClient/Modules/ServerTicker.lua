// Server Ticker

SS.ServerTicker          = {}
SS.ServerTicker.Fade     = false
SS.ServerTicker.Enabled  = false
SS.ServerTicker.Text     = ""
SS.ServerTicker.Time     = 0
SS.ServerTicker.Position = 0

// Server ticker usermessage

function SS.ServerTicker.Hook(Message)
	local Text = Message:ReadString()
	local Time = Message:ReadShort()
	
	// Variables
	
	SS.ServerTicker.Text     = Text
	SS.ServerTicker.Time     = RealTime()
	SS.ServerTicker.Enabled  = true
	SS.ServerTicker.Fade     = false
	SS.ServerTicker.Position = 0
	
	// Timer
	
	timer.Create("SS.ServerTicker", Time, 1, SS.ServerTicker.Close)
end

usermessage.Hook("SS.ServerTicker", SS.ServerTicker.Hook)

// Close server ticker

function SS.ServerTicker.Close()
	SS.ServerTicker.Fade = true
end

// Draw server ticker

function SS.ServerTicker.Draw()
	// Enabled
	
	if not (SS.Config.Request("Enable Top Bar")) then return end
	
	// Hidden
	
	if (SS.Lib.Hidden(SS.Client, "Bar")) then return end
	
	// Enabled
	
	if (SS.ServerTicker.Enabled) then
		local Time = RealTime() - SS.ServerTicker.Time
		
		// Color
		
		local Col = Color(100, 100, 100, 255)
		
		// Position
		
		local Position = 0
		
		// Fade
		
		if not (SS.ServerTicker.Fade) then
			Position = math.Clamp(SS.ServerTicker.Position + (Time / 2), 0, 26)
		else
			Position = math.Clamp(SS.ServerTicker.Position - (Time / 2), 0, 26)
		end
		
		// Position
		
		SS.ServerTicker.Position = Position
		
		// Box
		
		draw.RoundedBox(0, 0, Position, ScrW(), 24, Col)
		
		// Border
		
		local C = SS.Lib.GetTeamColor()
		
		// Group color
		
		if not (SS.Config.Request("Enable Bar Group Color", "Boolean", true)) then
			C = Color(255, 255, 255, 255)
		end
		
		// Box
		
		draw.RoundedBox(0, 0, Position + 24, ScrW(), 2, C)
		
		// Text
		
		draw.SimpleText(SS.ServerTicker.Text, "Default", 6, Position + 6, Color(0, 0, 0, 255), 0, 0)
		draw.SimpleText(SS.ServerTicker.Text, "Default", 5, Position + 5, Color(255, 255, 255, 255), 0, 0)
		
		if (SS.ServerTicker.Fade) then
			if (Position <= 0) then
				SS.ServerTicker.Enabled = false
			end
		end
	end
end

hook.Add("HUDPaint", "SS.ServerTicker.Draw", SS.ServerTicker.Draw)
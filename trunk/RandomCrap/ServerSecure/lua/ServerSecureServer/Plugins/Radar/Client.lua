// Client

local Radar = {}

// Tables

Radar.Custom = {}
Radar.Settings = {}

// Settings

Radar.Settings.W = 128
Radar.Settings.H = 128
Radar.Settings.Color = Color(50, 50, 50, 200)
Radar.Settings.Distance = 4120

// Locals

local User = LocalPlayer()

// ConVars

CreateClientConVar("serversecure_showradar", 0, true, true)

// Draw

function Radar.Point(Table, X, Y)
	for K, V in pairs(Table) do
		local Valid = V:IsValid()
		
		if (Valid) then
			local ID = "None"
			
			// Player
			
			if (V:IsPlayer()) then
				ID = V:Name()
			else
				ID = V.ID
			end
			
			// Positions
			
			local PX = X + (Radar.Settings.W / 2)
			local PY = Y + (Radar.Settings.H / 2)
			
			// Dist
			
			local Dist = V:GetPos() - User:GetPos()
			
			// Math
			
			local Player = V:IsPlayer()
			
			// Alive
			
			if not (Player) or (V:Alive()) then
				if (User != V) then
					if (Dist:Length() < Radar.Settings.Distance) then
						local NX = (Dist.x / Radar.Settings.Distance)
						local NY = (Dist.y / Radar.Settings.Distance)
						
						// Z
						
						local Z = math.sqrt(NX * NX + NY * NY)
						
						// Something
						
						local Something = math.Deg2Rad(math.Rad2Deg(math.atan2(NX, NY) ) - math.Rad2Deg(math.atan2(User:GetAimVector().x, User:GetAimVector().y)) - 90)
						
						// Cos and sin
						
						NX = math.cos(Something) * Z
						NY = math.sin(Something) * Z
						
						// Color
						
						local Col = Color(255, 255, 255, 255)
						
						// Player
						
						local Player = V:IsPlayer()
						
						// Check
						
						if (Player) then
							local Side = V:Team()
							
							// Color
							
							Col = team.GetColor(Side)
						else
							local R, G, B, A = V:GetColor()
							
							// Color
							
							Col = Color(R, G, B, A)
						end
						
						// X and Y
						
						local X = PX + NX * Radar.Settings.W / 2 - 4
						local Y = PY + NY * Radar.Settings.H / 2 - 4
						
						// Text
						
						draw.SimpleText(ID, "Default", X, Y + 16, Color(255, 255, 255, 255), 1, 1)
						
						// Box
						
						draw.RoundedBox(0, X, Y, 4, 4, Col)
					end
				end
			end
		else
			Radar.Custom[K] = nil
		end
	end
end

// Code

function Radar.Draw()
	if (GetConVarNumber("serversecure_showradar") == 0) then return end
	
	// X and Y
	
	local X = (ScrW() - Radar.Settings.W) - 16
	local Y = 64
	
	// Ticker
	
	if (SS.ServerTicker.Enabled) then
		Y = Y + SS.ServerTicker.Position
	end
	
	// Color
	
	local Side = User:Team()
	
	// Color
	
	local Col = team.GetColor(Side)

	// Players
	
	local Players = player.GetAll()
	
	// Box
	
	SS.GUI.Box(X, Y, Radar.Settings.W, Radar.Settings.H, Radar.Settings.Color, 2, Col, 2)
	
	// Lines
	
	draw.RoundedBox(0, X + (Radar.Settings.W / 2), Y, 1, Radar.Settings.H, Color(255, 255, 255, 255))
	draw.RoundedBox(0, X, Y + (Radar.Settings.H / 2), Radar.Settings.W, 1, Color(255, 255, 255, 255))
	
	// Point
	
	Radar.Point(Players, X, Y)
	Radar.Point(Radar.Custom, X, Y)
end

hook.Add("HUDPaint", "Radar.Draw", Radar.Draw)

// Custom radar

function Radar.Console(Player, Command, Args)
	if (Args == nil) or (Args[1] == nil) then return end
	
	// Trace
	
	local TR = utilx.GetPlayerTrace(Player, Player:GetCursorAimVector())
	
	// Real trace
	
	local Trace = util.TraceLine(TR)
	
	// Trace entity
	
	if (Trace.Entity and Trace.Entity:IsValid()) then
		local Index = Trace.Entity:EntIndex()
		
		// Custom
		
		Radar.Custom[Index] = Trace.Entity
		
		// Entity ID
		
		Trace.Entity.ID = Args[1]
	end
end

concommand.Add("serversecure_radarentity", Radar.Console)
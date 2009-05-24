// GUI

SS.GUI       = {}
SS.GUI.Panel = {}
SS.GUI.Font  = "ServerSecureVerdana"

// Circle

local Circle = Material("ServerSecureMaterials/Circle")

// Player message

function SS.GUI.PlayerMessage(Message)
	local Type = Message:ReadShort()
	local Message = Message:ReadString()
	
	// Sound
	
	local Sound = "ambient/water/drip2.wav"
	
	// Type
	
	if (Type == 1) then
		Sound = "buttons/button10.wav"
	elseif (Type == 4) then
		Sound = "buttons/button15.wav"
	end
	
	// Add notify
	
	GAMEMODE:AddNotify(Message, Type, 10) 
	
	// Play sound
	
	surface.PlaySound(Sound)
end

usermessage.Hook("SS.PlayerMessage", SS.GUI.PlayerMessage)

// HUDPaint

function SS.GUI.Update()
	// Aim
	
	local Aim = LocalPlayer():GetCursorAimVector()
	
	// Trace
	
	local TR = utilx.GetPlayerTrace(LocalPlayer(), Aim)
	
	// Real trace line
	
	local Trace = util.TraceLine(TR)
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		local Living = V:Alive()
		
		// Living
		
		if (Living) then
			if (V != LocalPlayer()) then
				local Pos = V:GetShootPos() - LocalPlayer():GetShootPos()
				local Leng = Pos:Length()
				
				// Config
				
				local Fade = SS.Config.Request("Name Fading Distance", "Number", -1)
				
				// Check
				
				if (Leng < Fade or Fade == -1) then
					if (Leng < 128) then
						Leng = 128
					end
					
					// Alpha
					
					local Alpha = math.Clamp(255 - ((255 / Fade) * Leng), 0, 200)
					
					// Fade
					
					if (Fade == -1) then Alpha = 255 end
					
					// X and Y
					
					local X = V:GetShootPos():ToScreen().x - 6
					local Y = V:GetShootPos():ToScreen().y + 100
					
					// Color
					
					local Col = team.GetColor(V:Team())
					
					// Not hidden
					
					if not (SS.Lib.Hidden(V, "Name")) then
						if (SS.Config.Request("Show Overhead Names", "Boolean", true)) then
							local ID = V:Name()
							local Index = V:Team()
							
							// Symbol
							
							if (SS.Config.Request("Show Group Symbols", "Boolean", true)) then
								local Symbol = SS.Groups.GetGroupSymbol(Index)
								
								// Check if there is a symbol
								
								if (Symbol != "") then ID = "["..Symbol.."] "..ID end
							end
							
							// Name
							
							draw.SimpleText(ID, "ChatFont", X, (Y - 178), Color(Col.r, Col.g, Col.b, Alpha), 1, 1)
						end
						
						// NY and Cur
						
						local NY  = (Y - 178)
						local Cur = 0
						
						// Data
						
						local Data = SS.Parts.Request(V, "Name")
						
						if (Data) then
							for B, J in pairs(Data) do
								if (J != "") then
									Cur = Cur + 16
									
									// Text
									
									SS.GUI.DrawShadowedText(J, SS.GUI.Font, X, NY + Cur, Color(255, 255, 255, Alpha), 1, 1)
								end
							end
						end
					end
					
					// Not hidden
					
					if not (SS.Lib.Hidden(V, "Hover")) then
						if (SS.Config.Request("Show Hover Information", "Boolean", true)) then
							if (Trace.Entity) then
								if (Trace.Entity == V) then
									local HX = gui.MouseX() - 16
									local HY = gui.MouseY() - 64
									
									// Variables
									
									local Cur = 0
									local Number = 0
									local Amount = 0
									
									// Data
									
									local Data = SS.Parts.Request(V, "Hover")
									
									// Check data exists
									
									if (Data) then
										// Font
										
										surface.SetFont(SS.GUI.Font)
										
										// Loop
										
										for B, J in pairs(Data) do
											if (J != "") then
												Number = Number + 1
												
												// W and H
												
												local W, H = surface.GetTextSize(J)
												
												// Check W
												
												if (W > Amount) then
													Amount = W
												end
											end
										end
										
										// Box dimensions
										
										local BX, BY, BW, BH = (HX - 48), HY, (Amount + 32), ((18 * Number) + 10)
										
										// Draw box
										
										SS.GUI.Box(BX, BY, BW, BH + 2, Color(50, 50, 50, Alpha), 2)
										
										// Data
										
										local Data = SS.Parts.Request(V, "Hover")
										
										// Loop
										
										for B, J in pairs(Data) do
											if (J != "") then
												Cur = Cur + 16
												
												// Text
												
												SS.GUI.DrawShadowedText(J, SS.GUI.Font, BX + (BW / 2), BY + Cur, Color(255, 255, 255, Alpha), 1, 1)
											end
										end
									end
								end
							end
						end
					end
				end
				
				// Show team circles
				
				if (SS.Config.Request("Show Team Circles", "Boolean", true)) then
					// Thanks Bro_21 for letting me use this idea
					
					local Pos = EyePos()
					local Ang = EyeAngles()
					
					// Start the 3D camera
					
					cam.Start3D(Pos, Ang)
					
					// Render material
					
					render.SetMaterial(Circle)
					
					// Trace table
					
					local Trace = {}
					
					Trace.start = V:GetPos()
					Trace.endpos = Trace.start + Vector(0, 0, -256)
					Trace.filter = V
					Trace.mask = COLLISION_GROUP_WORLD
					
					// Get the traceline
					
					Trace = util.TraceLine(Trace)
					
					// Draw the quads
					
					if (Trace.Fraction < 1) then
						render.DrawQuadEasy(V:GetPos(), Trace.HitNormal, 48, 48, SS.Lib.GetTeamColor(V))
						render.DrawQuadEasy(V:GetPos(), Trace.HitNormal * -1, 48, 48, SS.Lib.GetTeamColor(V))
					end
					
					// End the 3D camera
					
					cam.End3D()
				end
			end
		end
	end
end

hook.Add("HUDPaint", "SS.GUI.Update", SS.GUI.Update)

// Material

SS.GUI.Materials = {}

function SS.GUI.Material(Texture)
	if (SS.GUI.Materials[Texture]) then return SS.GUI.Materials[Texture] end
	
	// Update material
	
	SS.GUI.Materials[Texture] = Material(Texture)
	
	// Return material
	
	return SS.GUI.Materials[Texture]
end

// Draw a box

function SS.GUI.Box(X, Y, W, H, Col, Shadow)
	if (Shadow) then
		draw.RoundedBox(4, X + Shadow, Y + Shadow, W, H, Color(0, 0, 0, Col.a / 3))
	end
	
	// Box
	
	draw.RoundedBox(4, X, Y, W, H, Col)
end

// Draw shadowed text

function SS.GUI.DrawShadowedText(Text, Font, X, Y, Col, XA, YA)
	draw.SimpleText(Text, Font, X + 1, Y + 1, Color(0, 0, 0, Col.a), XA, YA)
	draw.SimpleText(Text, Font, X, Y, Col, XA, YA)
end
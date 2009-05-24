// Translate

local Plugin = SS.Plugins:New("Translate")

// Create command

local Translate = SS.ChatCommands:New("Translate")

// Branch flag

SS.Flags.Branch("Moderator", "Translate")

// Command

function Translate.Command(Player, Args)
	local Selected = Player:EntitiesSelected()
	
	if not (Selected) then
		SS.PlayerMessage(Player, "Select some entities using "..SS.ChatCommands.Prefix().."select!", 1)
		
		return
	end
	
	// Check table exists
	
	Player.Translate = Player.Translate or {}

	// Active
	
	if (Player.Translate.Active) then
		Player.Translate.Active = false
		
		SS.PlayerMessage(Player, "You have exited translate mode!", 0)
	else
		Player.Translate.Active = true
		Player.Translate.Freeze = Args[1]
		
		SS.PlayerMessage(Player, "You have entered translate mode!", 0)
	end
end

// Key pressed

function Translate.KeyPress(Player, Key)
	local Time = RealTime()
	
	if (Player.Translate and Player.Translate.Active) then
		if (Key == IN_FORWARD or Key == IN_BACK or Key == IN_MOVELEFT or Key == IN_MOVERIGHT
			or Key == IN_JUMP or Key == IN_DUCK) then
			
			if (Player.Translate.Next) then
				if (Player.Translate.Next > Time) then
					local Seconds = Player.Translate.Next - Time
					
					Seconds = string.ToMinutesSeconds(Seconds)
					
					if (Seconds != "00:00") then
						SS.PlayerMessage(Player, "You must wait "..Seconds.." before you can use translate again!", 1)
						
						return
					end
				end
			end
			
			// Get the entities
			
			local Selected = Player:EntitiesSelected()
			
			if not (Selected) then
				Player.Translate.Active = false
				
				return
			end
			
			// Check
			
			if (table.Count(Selected) > 1) then
				SS.PlayerMessage(Player, "You may only translate one entity at a time!", 1)
				
				Player.Translate.Active = false
				
				return
			end
			
			// Selected
			
			local _, Value = next(Selected)
			
			// Deselect current entities
			
			Player:DeselectEntities()
			
			// Do the main stuff
			
			undo.Create("Translate")
			
			local Class      = Value:GetClass()
			local Model      = Value:GetModel()
			local Angles     = Value:GetAngles()
			local Material   = Value:GetMaterial()
			local R, G, B, A = Value:GetColor()
			
			local Col = {R, G, B, A}
			
			local Entity = ents.Create(Class)
			
			Entity:SetModel(Model)
			Entity:SetAngles(Angles)
			Entity:SetMaterial(Material)
			Entity:SetColor(Col[1], Col[2], Col[3], Col[4])
			
			// Vector stuff
			
			local VectorOBBMaxs = Value:OBBMaxs()
			local VectorOBBMins = Value:OBBMins()
			
			local TempUp = Value:GetUp()
			local TempRight = Value:GetRight()
			local TempForward = Value:GetForward()
			
			local VectorPos = Value:GetPos()
			
			local Len = (VectorOBBMaxs.z - VectorOBBMins.z)
			local VectorUp = VectorPos + TempUp * Len
			local VectorDown = VectorPos + TempUp * -Len
			
			local Len = (VectorOBBMaxs.y - VectorOBBMins.y)
			local VectorRight = VectorPos + TempRight * Len
			local VectorLeft = VectorPos + TempRight * -Len
			
			local Len = (VectorOBBMaxs.x - VectorOBBMins.x)
			local VectorForward = VectorPos + TempForward * Len
			local VectorBackward = VectorPos + TempForward * -Len
			
			if (Key == IN_FORWARD) then
				VectorPos = VectorBackward
			elseif (Key == IN_BACK) then
				VectorPos = VectorForward
			elseif (Key == IN_MOVERIGHT) then
				VectorPos = VectorLeft
			elseif (Key == IN_MOVELEFT) then
				VectorPos = VectorRight
			elseif (Key == IN_JUMP) then
				VectorPos = VectorUp
			elseif (Key == IN_DUCK) then
				VectorPos = VectorDown
			end
			
			// Set the position
			
			Entity:SetPos(VectorPos)
			Entity:Spawn()
			
			// Checks
			
			local World = Entity:IsInWorld()
			
			if not (World) then Entity:Remove() end
			
			local Area = ents.FindInSphere(Entity:GetPos(), 128)
			
			for B, J in pairs(Area) do
				if (J != Entity and J != Value) then
					if (J:GetModel() == Entity:GetModel()) then
						local VectorJ = J:GetPos()
						
						VectorJ.x = math.Round(VectorJ.x)
						VectorJ.y = math.Round(VectorJ.y)
						VectorJ.z = math.Round(VectorJ.z)
						
						local VectorEntity = Entity:GetPos()
						
						VectorEntity.x = math.Round(VectorEntity.x)
						VectorEntity.y = math.Round(VectorEntity.y)
						VectorEntity.z = math.Round(VectorEntity.z)
						
						if (VectorJ == VectorEntity) then
							J:Remove()
						end
					end
				end
			end
			
			// Valid
			
			if (SS.Lib.Valid(Entity)) then
				Player:AddCount("props", Entity)
				Player:AddCleanup("props", Entity)
				
				// Add it to the player's undo table
				
				undo.AddEntity(Entity)
				
				// Freeze it
				
				if (Player.Translate.Freeze == 1) then
					Entity:GetPhysicsObject():EnableMotion(false)
					
					Player:AddFrozenPhysicsObject(Entity, Entity:GetPhysicsObject())
				end
				
				// Select it
				
				Player:SelectEntity(Entity)
			end
			
			// Finish undo
			
			undo.SetPlayer(Player)
			undo.Finish()
			
			// Set a delay
			
			Player.Translate.Next = Time + 1
		end
	end
end

hook.Add("KeyPress", "Translate.KeyPress", Translate.KeyPress)

Translate:Create(Translate.Command, {"Moderator", "Translate"}, "Stack entities with movement keys", "<Freeze 0|1>", 1, " ")

// Space for other plugins

function Plugin.ServerLoad()
	if (SS.PurchaseFlags) then
		local function Translate(Player)
			SS.PlayerMessage(Player, "Type "..SS.ChatCommands.Prefix().."translate <Freeze 0|1> to activate translate mode!", 0)
		end
		
		SS.PurchaseFlags.Add("Translate", "Flags [Translate]", 10, "Stack entities with movement keys", Translate)
	end
end

// Create

Plugin:Create()
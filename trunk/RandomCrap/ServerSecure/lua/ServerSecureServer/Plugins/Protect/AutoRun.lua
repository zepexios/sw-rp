local Plugin = SS.Plugins:New("Protect")

// Tables

Plugin.Protecting = {}

// Branch flag

SS.Flags.Branch("Moderator", "Protect")

// Protect

local function Protect(Player, Entity, Data)
	local Index = Entity:EntIndex()
	
	// Insert it
	
	Plugin.Protecting[Index] = {Entity, Player, Data.Flag}
	
	// Store entity modifier
	
	duplicator.StoreEntityModifier(Entity, "Protect", Data)

	return true
end

duplicator.RegisterEntityModifier("Protect", Protect)

// Chat command

local Command = SS.ChatCommands:New("Protect")

function Command.Command(Player, Args)
	local Selected = Player:EntitiesSelected()
	
	if not (Selected) then
		SS.PlayerMessage(Player, "Select some entities first using "..SS.ChatCommands.Prefix().."select!", 1)
		
		return
	end
	
	local Number = 0
	
	for K, V in pairs(Selected) do
		local Flag = false
		
		if (Args[1]) then
			Flag = Args[1]
		end
		
		Protect(Player, V, {Flag = Flag})
		
		Number = Number + 1
	end
	
	SS.PlayerMessage(Player, "Protected "..Number.." entities from noclip!", 0)
end

Command:Create(Command.Command, {"Moderator", "Protect"}, "Protect selected entities from noclip", "<Flag>", 0, " ")

// Think

function Plugin.ServerThink()
	for K, V in pairs(Plugin.Protecting) do
		local Valid = SS.Lib.Valid(V[1])
		
		if (V[1] and Valid) then
			local Players = player.GetAll()
			
			for B, J in pairs(Players) do
				if (J != V[2]) then
					if (J:GetMoveType() == MOVETYPE_NOCLIP) then
						if not (V[3]) or not (SS.Flags.PlayerHas(J, V[3])) then
							local Len = V[1]:GetPos() - J:GetPos()
							
							Len = Len:Length()
							
							local Radius = V[1]:BoundingRadius()
							
							if (Len <= (Radius + 16)) then
								J:SetMoveType(MOVETYPE_WALK)
								
								// Check
								
								if (V[3]) then
									SS.PlayerMessage(J, "This entity has noclip prevention, you need the "..V[3].." flag!", 1)
								else
									SS.PlayerMessage(J, "This entity has noclip prevention!", 1)
								end
							end
						end
					end
				end
			end
		else
			Plugin.Protecting[K] = nil
		end
	end
end

// Space for other plugins

function Plugin.ServerLoad()
	if (SS.PurchaseFlags) then
		local function Protect(Player)
			SS.PlayerMessage(Player, "Type "..SS.ChatCommands.Prefix().."protect to protect your entities against noclip!", 0)
		end
		
		// Add the flag purchase
		
		SS.PurchaseFlags.Add("Protect", "Flags [Protect]", 5, "Protect your entities from noclip", Protect)
	end
end

// Create

Plugin:Create()
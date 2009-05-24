// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Drop

local Command = SS.ChatCommands:New("Drop")

function Command.Command(Player, Args)
	local Amount = Args[1]
	
	// Number
	
	if not SS.Lib.StringNumber(Amount) then SS.PlayerMessage(Player, "That isn't a valid amount!", 1) return end
	
	// Floor
	
	Amount = math.floor(Amount)
	
	// Amount is too small
	
	if (Amount <= 0) then SS.PlayerMessage(Player, "That amount is too small!", 1) return end
	
	// Can afford it
	
	if (CVAR.Request(Player, "Points") >= Amount) then
		SS.Points.PlayerTake(Player, Amount)
		
		// Trace
		
		local Trace = Player:ServerSecureTraceLine()
		
		// Entity
		
		local Entity = ents.Create("Points")
		
		// Amount
		
		Entity.Amount = Amount
		
		// Spawn
		
		Entity:SetPos(Trace.HitPos + (Player:GetAimVector() * -5))
		Entity:Spawn()
		
		// Set player
		
		Entity:SetPlayer(Player)
		
		// Add count
		
		Player:AddCount("props", Entity)
		Player:AddCleanup("props", Entity)
		
		// Undo function
		
		local function Function(Undo, Player, Entity, Amount)
			if (SS.Lib.Valid(Entity)) then
				SS.Points.PlayerGain(Player, Amount)
			end
		end
		
		// Undo
		
		undo.Create("Points")
			undo.AddEntity(Entity)
			undo.AddFunction(Function, Player, Entity, Amount)
			undo.SetPlayer(Player)
		undo.Finish()
		
		// Message
		
		SS.PlayerMessage(Player, "You dropped "..Amount.." "..SS.Config.Request("Points Name").."!", 0)
	else
		SS.PlayerMessage(Player, "You don't have enough "..SS.Config.Request("Points Name").."!", 1)
	end
end

Command:Create(Command.Command, {"Basic"}, "Drop a specific amount of points", "<Amount>", 1, " ")
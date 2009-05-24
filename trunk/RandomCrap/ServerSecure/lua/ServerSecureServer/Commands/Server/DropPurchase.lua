// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Drop purchase

local Command = SS.ChatCommands:New("DropPurchase")

// Branch flag

SS.Flags.Branch("Server", "DropPurchase")

// Give purchase command

function Command.Command(Player, Args)
	local String = table.concat(Args, " ")
	
	// Purchase
	
	local Purchase = false
	
	// Loop
	
	for K, V in pairs(SS.Purchases.List) do
		if (string.lower(String) == string.lower(V[1])) then
			Purchase = {V[1], V[5]}
		end
	end
	
	// Purchase
	
	if not (Purchase) then SS.PlayerMessage(Player, "Could not find purchase "..String.."!", 1) return end
	
	// Trace
	
	local Trace = Player:ServerSecureTraceLine()
	
	// Entity
	
	local Entity = ents.Create("Purchase")
	
	Entity.Purchase = Purchase
	
	// Spawn
	
	Entity:SetPos(Trace.HitPos + (Player:GetAimVector() * -5))
	Entity:Spawn()
	
	// Set player
	
	Entity:SetPlayer(Player)
	
	// Add count
	
	Player:AddCount("props", Entity)
	Player:AddCleanup("props", Entity)
	
	// Undo
	
	undo.Create("Prop")
		undo.AddEntity(Entity)
		undo.SetPlayer(Player)
	undo.Finish()
	
	// Message
	
	SS.PlayerMessage(Player, "Successfully dropped purchase "..Purchase[2].."!", 0)
end

Command:Create(Command.Command, {"DropPurchase", "Server"}, "Drop a specific purchase", "<Purchase>", 1, " ")
// Noclip

local Noclip = SS.ChatCommands:New("Noclip")

// Noclip command

function Noclip.Command(Player, Args)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Noclip")
	
	// Check if player is allowed
	
	if (Allowed) then
		if (Player:GetMoveType() == MOVETYPE_NOCLIP) then
			Player:SetMoveType(MOVETYPE_WALK)
		else
			Player:SetMoveType(MOVETYPE_NOCLIP)
		end
	end
end

Noclip:Create(Noclip.Command, {"Basic"}, "Enter noclip mode to fly around the map")
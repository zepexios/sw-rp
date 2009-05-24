// Block

local Plugin = SS.Plugins:New("Block")

// Player spawn

function Plugin.PlayerSpawn(Player)
	Player:SetCollisionGroup(11)
end

// Create

Plugin:Create()
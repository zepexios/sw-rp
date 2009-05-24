// Purchase weapons

SS.PurchaseWeapons = SS.Plugins:New("SS.PurchaseWeapons")

// Store all weapons

SS.PurchaseWeapons.List = {}

// When script loads

function SS.PurchaseWeapons.ServerLoad()
	SS.PurchaseWeapons.Generate()
end

// Add a tool to the list

function SS.PurchaseWeapons.Add(Weapon, ID, Groups, Cost, Friendly, Description)
	SS.PurchaseWeapons.List[Weapon] = {Groups, ID, Cost, Friendly, Description}
end

// Generate purchases

function SS.PurchaseWeapons.Generate()
	for K, V in pairs(SS.PurchaseWeapons.List) do
		local Tool = SS.Purchases:New(V[2], V[4])
		
		// Create
		
		Tool:Create(V[3], V[1], "Weapons", V[5])
	end
end

// When a player is given weapons

function SS.PurchaseWeapons.PlayerGivenWeapons(Player)
	for K, V in pairs(SS.PurchaseWeapons.List) do
		if (SS.Purchases.PlayerHas(Player, V[2])) then
			Player:Give(K)
		end
	end
end

// Include the config file

include("Config.lua")

// Create

SS.PurchaseWeapons:Create()
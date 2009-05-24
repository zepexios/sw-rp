// Purchases

SS.Purchases          = {} -- Purchase table
SS.Purchases.List     = {} -- Where purchases are stored
SS.Purchases.Packages = {} -- Packages table

// Add a new purchase

function SS.Purchases.Add(Index, Price, Groups, Category, Friendly, Description, Condition, Removed, Given)
	Price = (Price * SS.Config.Request("Points Given"))
	
	// Insert it
	
	table.insert(SS.Purchases.List, {Index, Price, Groups, Category, Friendly, Description, Condition, Removed, Given})
end

// New purchase

function SS.Purchases:New(Index, Friendly)
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Variables
	
	Table.Name = Index
	Table.Friendly = Friendly
	
	// Return table
	
	return Table
end

// Categories

function SS.Purchases.Categories()
	local Categories = {}
	
	// Loop
	
	for K, V in pairs(SS.Purchases.List) do
		local Category = V[4]
		
		// Categories
		
		Categories[Category] = Categories[Category] or {}
		
		// Variables
		
		local Friendly    = V[5]
		local Index       = V[1]
		local Cost        = V[2]
		local Description = V[6]
		local Condition   = V[7]
		
		// Insert
		
		Categories[Category][Friendly] = {Cost, Index, Description, Condition}
	end
	
	// Return
	
	return Categories
end

// Package

function SS.Purchases.Package(Friendly, ID, Price, Groups, Description, ...)
	local Items = {}
	
	// Loop
	
	for I = 1, table.getn(arg) do
		Items[I] = arg[I]
	end
	
	// Purchases
	
	SS.Purchases.Packages[ID] = Items
	
	// Purchase
	
	local Purchase = SS.Purchases:New(ID, Friendly) Purchase:Create(Price, Groups, "Packages", Description)
end

// Create purchase

function SS.Purchases:Create(Cost, Groups, Category, Description)
	self.PurchaseCondition = self.PurchaseCondition or function() return true end
	self.PurchaseRemoved = self.PurchaseRemoved or function() end
	self.PurchaseGiven = self.PurchaseGiven or function() end
	
	// Add the purchase
	
	SS.Purchases.Add(self.Name, Cost, Groups, Category, self.Friendly, Description, self.PurchaseCondition, self.PurchaseRemoved, self.PurchaseGiven)
end

// Player has

function SS.Purchases.PlayerHas(Player, Index)
	local Purchases = CVAR.Request(Player, "Purchases")
	
	// Try our main player purchases table
	
	for K, V in pairs(Purchases) do
		if (V == Index) then
			return true
		end
	end
	
	// Try the purchase list
	
	for K, V in pairs(SS.Purchases.List) do
		if (V[1] == Index) then
			if (SS.Flags.PlayerHas(Player, V[3])) then
				return true
			end
		end
	end
	
	// Try all the packages
	
	for K, V in pairs(SS.Purchases.Packages) do
		for B, J in pairs(V) do
			if (J == Index) then
				if (SS.Purchases.PlayerHas(Player, K)) then
					return true
				end
			end
		end
	end
	
	return false
end

// Purchase menu

function SS.Purchases.Menu(Player, Index)
	for K, V in pairs(SS.Purchases.List) do
		if (Index == V[1]) then
			if (SS.Purchases.PlayerHas(Player, V[1])) or not (V[7](Player, V[1])) then
				SS.PlayerMessage(Player, "You cannot purchase "..V[1].."!", 1)
				
				// Return false
				
				return false
			end
			
			// Check if they can afford it
			
			if (CVAR.Request(Player, "Points") >= V[2]) then
				CVAR.Update(Player, "Points", CVAR.Request(Player, "Points") - V[2])
				
				// Message
				
				SS.PlayerMessage(Player, "You have  "..V[5].."!", 0)
				
				// Give
				
				SS.Purchases.PlayerGive(Player, V[1], V[5])
				
				// Update GUI
				
				SS.Player.PlayerUpdateGUI(Player)
			else
				local Needed = V[2] - CVAR.Request(Player, "Points")
				
				SS.PlayerMessage(Player, "You need "..Needed.." more "..SS.Config.Request("Points Name").."!", 0)
			end
		end
	end
end

// Player give

function SS.Purchases.PlayerGive(Player, Index, Friendly)
	CVAR.Request(Player, "Purchases")[Index] = Index
	
	// If it is a purchase then give all included purchases

	for K, V in pairs(SS.Purchases.List) do
		if (Index == V[1]) then
			if (V[9]) then
				V[9](Player, Index)
			end
		end
	end
	
	// Run hook
	
	SS.Hooks.Run("PlayerGivenPurchase", Player, Index, Friendly)
end

// Take purchase

function SS.Purchases.PlayerTake(Player, Index)
	for K, V in pairs(SS.Purchases.List) do
		if (V[1] == Index) then
			V[8](Player, Index)
		end
	end
	
	// Remove the purchase
	
	CVAR.Request(Player, "Purchases")[Index] = nil
end

// Free purchases

function SS.Purchases.GiveFree(Player)
	CVAR.New(Player, "Purchases", {})
	
	// Run hook
	
	SS.Hooks.Run("PlayerGiveFreePurchases", Player)
end

// Hook into player set variables

SS.Hooks.Add("SS.Purchases.Free", "PlayerSetVariables", SS.Purchases.GiveFree)
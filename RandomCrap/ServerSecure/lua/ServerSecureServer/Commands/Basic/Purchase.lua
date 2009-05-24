// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Purchase

local Purchase = SS.ChatCommands:New("Purchase")

// Purchase command

function Purchase.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Purchase Categories")
	
	// Categories
	
	local Categories = SS.Purchases.Categories()
	
	// Loop
	
	for K, V in pairs(Categories) do
		Panel:Button(K, {Purchase.Category, K})
	end
	
	// Send
	
	Panel:Send()
end

// Prepurchase

function Purchase.Prepurchase(Player, Index)
	if (Index) then
		for K, V in pairs(SS.Purchases.List) do
			if (Index == V[1]) then
				local Panel = SS.Panel:New(Player, "Purchase ("..Index..")")
				
				// Words
				
				Panel:Words("Description: "..V[6])
				Panel:Words("Category: "..V[4])
				Panel:Words("Price: "..V[2].." "..SS.Config.Request("Points Name"))
				
				// Button
				
				Panel:Button("Purchase", {SS.Purchases.Menu, Index})
				
				// Send
				
				Panel:Send()
				
				// Return true
				
				return true
			end
		end
	end
end

// Category

function Purchase.Category(Player, Category)
	local Index = Category
	
	// Category
	
	if not (SS.Purchases.Categories()[Index]) then
		SS.PlayerMessage(Player, "The purchase category '"..Index.."' doesn't exist!", 1)
	else
		local Panel = SS.Panel:New(Player, "Purchase ("..Index..")")
		
		// Added
		
		local Added = false
		
		// Sort
		
		local Sort = SS.Purchases.Categories()[Index]
		
		// Sort
		
		table.sort(Sort, function(A, B) return (A[1] > B[1]) end)
		
		// Loop
		
		for K, V in pairs(Sort) do
			if not (SS.Purchases.PlayerHas(Player, V[2])) and (V[4](Player, V[2])) then
				Panel:Words(V[3])
				
				// Button
				
				Panel:Button(K.." ("..V[1].." "..SS.Config.Request("Points Name")..")", {Purchase.Prepurchase, V[2]})
				
				// Added
				
				Added = true
			end
		end
		
		// Added
		
		if not (Added) then
			Panel:Words("You have purchased everything in this category!")
		end
		
		// Send
		
		Panel:Send()
	end
end

// Create it

Purchase:Create(Purchase.Command, {"Basic"}, "View the purchases menu")

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."purchase to access the purchases menu!")
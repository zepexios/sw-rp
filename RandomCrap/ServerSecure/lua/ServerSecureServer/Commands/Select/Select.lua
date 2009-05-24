// Select

local Select = SS.ChatCommands:New("Select")

// Select command

function Select.Command(Player, Args)
	local TR = Player:ServerSecureTraceLine()
	
	// Valid
	
	if (SS.Lib.Valid(TR.Entity)) then
		// Check
		
		if (TR.Entity:IsNPC() or TR.Entity:IsPlayer()) then
			SS.PlayerMessage(Player, "You cannot select this entity class!", 1)
			
			// Return
			
			return
		end
		
		// Belong
		
		if not (Player:IsEntityOwner(TR.Entity)) then
			SS.PlayerMessage(Player, "This entity does not belong to you!", 1)
			
			// Return
			
			return
		end
		
		// New
		
		local Index = TR.Entity:EntIndex()
		
		// New
		
		TVAR.New(Player, "Selected", {})
		
		// TVAR
		
		if (TVAR.Request(Player, "Selected")[Index]) then
			Player:DeselectEntity(TR.Entity)
		else
			local Select = Player:SelectEntity(TR.Entity)
			
			// Select
			
			if not (Select) then
				SS.PlayerMessage("This entity is already selected by another player!")
			end
		end
	else
		SS.PlayerMessage(Player, "You must aim at a valid entity!", 1)
	end
end

Select:Create(Select.Command, {"Basic"}, "Select or deselect an entity")

// Meta

local Meta = FindMetaTable("Player")

// Deselect all

function Meta:DeselectEntities()
	local Selected = TVAR.Request(self, "Selected")
	
	// Number
	
	local Number = 0
	
	// Selected
	
	if (Selected) then
		for K, V in pairs(Selected) do
			if (SS.Lib.Valid(V)) then
				self:DeselectEntity(V)
				
				// Increase number
				
				Number = Number + 1
			end
		end
	end
	
	// Return number
	
	return Number
end

// Selected entities

function Meta:EntitiesSelected()
	local Selected = TVAR.Request(self, "Selected")
	
	// Selected
	
	if (Selected) then
		for K, V in pairs(Selected) do
			if not (V) or not (SS.Lib.Valid(V)) then
				TVAR.Request(self, "Selected")[K] = nil
			end
		end
		
		// Count
		
		if (table.Count(Selected) == 0) then
			return false
		end
	end
	
	// Return selected
	
	return TVAR.Request(self, "Selected")
end

// Remove marker

function Meta:RemoveAxisMarker()
	timer.Remove("Player.CreateAxisMarker: "..self:UniqueID())
	
	// Valid
	
	if (SS.Lib.Valid(self.SelectAxisMarker)) then
		self.SelectAxisMarker:Remove()
	end
end

// Create marker

function Meta:CreateAxisMarker(Entity)
	self:RemoveAxisMarker()
	
	// Function
	
	local function Function(Player, Entity)
		local Selection = ents.Create("Selection")
		
		// Spawn
		
		Selection:SetAngles(Entity:GetAngles())
		Selection:SetPos(Entity:GetPos())
		Selection:SetParent(Entity)
		Selection:Spawn()
		
		// Set variable
		
		Player.SelectAxisMarker = Selection
	end
	
	// Timer
	
	timer.Create("Player.CreateAxisMarker: "..self:UniqueID(), 1, 1, Function, self, Entity)
end

// Select entity

function Meta:SelectEntity(Entity)
	if not (Entity) or not (SS.Lib.Valid(Entity)) then return false end
	
	// NPC or player
	
	if (Entity:IsNPC() or Entity:IsPlayer()) then return false end
	
	// Index
	
	local Index = Entity:EntIndex()
	
	// TVAR
	
	TVAR.New(self, "Selected", {})
	TVAR.Request(self, "Selected")[Index] = Entity
	
	// Color
	
	local R, G, B, A = Entity:GetColor()
	
	// Old material and color
	
	Entity.SelectedColor = {R, G, B, A}
	Entity.SelectMaterial = Entity:GetMaterial()
	
	// Set new material and color
	
	Entity:SetMaterial("models/debug/debugwhite")
	Entity:SetColor(175, 255, 100, 255)
	
	// Create axis marker
	
	self:CreateAxisMarker(Entity)
	
	// Return true
	
	return true
end

// Deselect entity

function Meta:DeselectEntity(Entity)
	local Index = Entity:EntIndex()
	
	// TVAR
	
	TVAR.Request(self, "Selected")[Index] = nil
	
	// Material
	
	if (Entity.SelectMaterial) then
		local Material = Entity.SelectMaterial
		
		// Set material
		
		Entity:SetMaterial(Material)
	else
		Entity:SetMaterial("")
	end
	
	// Color
	
	if (Entity.SelectedColor) then
		local Col = Entity.SelectedColor
		
		// Set color
		
		Entity:SetColor(Col[1], Col[2], Col[3], Col[4])
	else
		Entity:SetColor(255, 255, 255, 255)
	end
	
	// Remove axis marker
	
	self:RemoveAxisMarker()
end
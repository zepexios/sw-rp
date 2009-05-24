// Meta

local Meta = FindMetaTable("Player") // Meta table

// Include

function Meta:IncludeClientsideFile(File)
	umsg.Start("SS.Lib.Include", self)
		umsg.String(File)
	umsg.End()
end

// PropSecure

function Meta:IsEntityOwner(Entity)
	for K, V in pairs(g_SBoxObjects) do
		for B, J in pairs(V) do
			for _, E in pairs(J) do
				if (E == Entity) then
					if (self:UniqueID() == K) then
						return true
					end
				end
			end
		end
	end
	
	// Return false
	
	return false
end

// Trace

function Meta:ServerSecureTraceLine()
	local Trace = util.GetPlayerTrace(self)
	
	// Traceline
	
	return util.TraceLine(Trace)
end

// Delete when killed

function Meta:DeleteOnDeath(Entity)
	TVAR.New(self, "DeleteOnDeath", {})
	
	// Index
	
	local Index = Entity:EntIndex()
	
	// TVAR
	
	TVAR.Request(self, "DeleteOnDeath")[Index] = Entity
end

// Player is ready

function Meta:IsPlayerReady()
	local Identity = self:SteamID()
	
	// CVAR
	
	if (CVAR.Store[Identity]) then
		return true
	end
	
	// Return false
	
	return false
end

// Hide GUI

function Meta:HideServerSecureGUI(ID, Type, Bool)
	TVAR.New(self, "Hidden", {})
	TVAR.Request(self, "Hidden")[Type] = TVAR.Request(self, "Hidden")[Type] or {}
	TVAR.Request(self, "Hidden")[Type][ID] = Bool
	
	// Number
	
	local Number = 1
	
	// Bool
	
	if not (Bool) then
		Number = 0
	end
	
	// Check number
	
	if (Number == 1) then
		self:SetNetworkedInt("SS.Hidden: "..Type, 1)
	elseif (Number == 0) then
		local Found = false
		
		// Loop
		
		for K, V in pairs(TVAR.Request(self, "Hidden")[Type]) do
			if (V) then
				self:SetNetworkedInt("SS.Hidden: "..Type, 1)
				
				// Found
				
				Found = true
				
				// Break
				
				break
			end
		end
		
		// Not found
		
		if not (Found) then
			self:SetNetworkedInt("SS.Hidden: "..Type, 0)
		end
	end
end

// Return chat value

function Meta:GetTextReturn()
	local Return = TVAR.Request(self, "TextReturnValue")
	
	// Return
	
	return Return
end

// Set return chat value

function Meta:SetTextReturn(Return, Priority)
	local Backup = self:GetTextReturn()
	
	// Backup
	
	if (Backup) then
		if (Backup[2] < Priority) then
			return
		end
	end
	
	// TVAR
	
	TVAR.Update(self, "TextReturnValue", {Return, Priority})
end
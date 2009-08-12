
if SERVER then
	function Player:Incapacitate(duration)
		umsg.Start("swo_incapacitation") //More efficient to toggle this way than to use a networked int
		umsg.End("swo_incapacitation")
		
		if self["swo_incap"] then //Already incapacitated
			if PlayerRagdoll:IsValid() then
				self:SetPos(PlayerRagdoll:GetPos() + Vector( 0, 0, 50 ))
				PlayerRagdoll:Remove()
			end
			self:Spawn()
			self["swo_incap"] = false
			self:DrawViewModel(true)
			self:DrawWorldModel(true)
		else
			if self:InVehicle() then
				self:ExitVehicle()
				self:GetParent():Remove()
			end
			if self:GetMoveType() == MOVETYPE_NOCLIP then
				self:SetMoveType(MOVETYPE_WALK)
			end
			self["swo_incap"] = true
			self:StripWeapons()
			self:DrawViewModel( false )
			self:DrawWorldModel( false )
			
			local PlayerRagdoll = ents.Create( "prop_ragdoll" )
			PlayerRagdoll:SetPos(self:GetPos())
			PlayerRagdoll:SetModel(self:GetModel())
			PlayerRagdoll:SetAngles(self:GetAngles())
			PlayerRagdoll:Spawn()
			PlayerRagdoll:Activate()
			local vel = self:GetVelocity()
			for x = 1, 14 do
				PlayerRagdoll:GetPhysicsObjectNum(x):SetVelocity(vel)
			end
			self:SetParent(prop)
			
			self:Spectate(OBS_MODE_CHASE)
			self:SpectateEntity(prop)
			
			duration = duration or 30
			
			timer.Create("swo_incap" .. tostring(self:SteamID()), 0, 1, function()
				if self["swo_incap"] then
					self:Incapacitate()
				end
			end)
		end
	end
	
else

	local function toggleIncapacitation()
		if LocalPlayer()["swo_incap"] then
			LocalPlayer()["swo_incap"] = false
		else
			LocalPlayer()["swo_incap"] = true
		end
	end
	usermessage.Hook("swo_incapacitate", toggleIncapacitation)
	
end
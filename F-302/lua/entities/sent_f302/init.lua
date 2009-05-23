AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:SpawnFunction( ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_f302" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	
	self.PositionSet = false;
	self.Target = Vector(0,0,0)
	
	
	if not (WireAddon == nil) then self.Inputs = Wire_CreateInputs(self.Entity,{"Hover", "View", "Disable Weapon"}) end
	if not (WireAddon == nil) then self.Outputs = Wire_CreateOutputs(self.Entity, { "X", "Y", "Z", "mouse1", "mouse2", "r", "shift"}) end
	self.reloadtime = (4);
	self.Hover = true;
	
	self.Entity:SetUseType( SIMPLE_USE )
	self.In=false
	self.Pilot=nil
	self.Entity:SetModel("models/alienate/vehicles/f302.mdl")	 --

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow(true);
		local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(10000)
		end
	self.Entity:StartMotionController()
	self.Accel=0
	self.SThink = 0
	self.WeaponTime = 0
	self.UseWeapon = true
	self.WeaponNextFire = 0.2 --1 = One second
	self.ProjectileMaxSpeed = 1000
	self.Sound_engineStart = 1
	
	self.Sound_engine = CreateSound( self.Entity, "alienate/F302Engine.wav" )


end


function ENT:OnRemove()
 	
	if self.In then
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel(true)
	self.Pilot:DrawWorldModel(true)
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool("isDriveF302",false)
	self.Pilot:SetPos(self.Entity:GetPos()+Vector(0,0,100))
	self.Sound_engine:Stop()
	end
end

function ENT:Think()
local enabled = self:Enabled();
	if not ValidEntity(self.Pilot) then self.Pilot=nil self.In=false end
	if self.In and self.Pilot and self.Pilot:IsValid() then
		if self.Pilot:KeyDown(IN_RELOAD) then 
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "r", 1)
			end
		else
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "r", 0)
			end
		end
	
		if self.Pilot:KeyDown(IN_SPEED) then
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "shift", 1)
			end
		else
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "shift", 0)
			end
		end

		if self.Pilot:KeyDown(IN_ATTACK) then 
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "mouse1", 1)
				if (self.UseWeapon == true) then
					if self.WeaponTime<CurTime() then
						self:FireWeapon()
						self.WeaponTime=CurTime()+self.WeaponNextFire
					end
				end
			end
		else
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "mouse1", 0)
			end
		end
	
		if self.Pilot:KeyDown(IN_ATTACK2) then
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "mouse2", 1)
			end
		else
			if not (WireAddon == nil) then
				Wire_TriggerOutput(self.Entity, "mouse2", 0)
			end
		end
		
		if not (WireAddon == nil) then
			local pos = self.Pilot:GetAimVector()
			local trace = util.GetPlayerTrace( self.Pilot )
			trace.filter = {self.Pilot,self.Entity}
			local EyeTrace = util.TraceLine( trace )
			
			Wire_TriggerOutput(self.Entity, "X", EyeTrace.HitPos.x)
			Wire_TriggerOutput(self.Entity, "Y", EyeTrace.HitPos.y)
			Wire_TriggerOutput(self.Entity, "Z", EyeTrace.HitPos.z)
		end
	
		
		if self.SThink<CurTime() then
			self.Sound_engine:Stop()
			self.Sound_engine:Play()
			self.SThink=CurTime()+3.0
		end
		
		self.Pilot:SetPos(self.Entity:GetPos())

		
		if self.Pilot:KeyDown(IN_USE) then
			self.Pilot:UnSpectate()
			self.Pilot:DrawViewModel(true)
			self.Pilot:DrawWorldModel(true)
			self.Pilot:Spawn()
			self.Pilot:SetNetworkedBool("isDriveF302",false)
			self.Pilot:SetPos(self.Entity:GetPos()+Vector(0,400,0))

			self.Accel=0
			self.In=false
		
			
			self.Entity:SetLocalVelocity(Vector(0,0,0))
			self.Pilot=nil
			self.Sound_engine:Stop()
		end			
			
		
		
		self.Entity:NextThink(CurTime())
	else
		self.Entity:NextThink(CurTime()+1)
	end

	
	
return true
end

function ENT:Use(ply,caller)
if not self.In then
	ply:Spectate( OBS_MODE_ROAMING ) -- OBS_MODE_ROAMING, OBS_MODE_IN_EYE
	ply:StripWeapons()
	self.Entity:GetPhysicsObject():Wake()
	self.Entity:GetPhysicsObject():EnableMotion(true)
	self.In=true
	ply:DrawViewModel(false)
	ply:DrawWorldModel(false)
	ply:SetNetworkedBool("isDriveF302",true)
	ply:SetNetworkedEntity("F302",self.Entity)
	self.Pilot=ply	
	self.Sound_engine:Play()

	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	if self.In then
		local num=0
		 if self.Pilot:KeyDown(IN_FORWARD) then
               num=500
           elseif self.Pilot:KeyDown(IN_BACK) then
               num=-500
          elseif self.Pilot:KeyDown(IN_SPEED) then
                num=1500
            end
		
		phys:Wake()
			self.Accel=math.Approach(self.Accel,num,10)
		 if not self.Hover then
             if self.Accel>-200 and self.Accel < 200 then return end --with out this you float
         end
		local move={}
			move.secondstoarrive	= 1
			move.pos = self.Entity:GetPos()+self.Entity:GetForward()*self.Accel
				if self.Pilot:KeyDown( IN_DUCK ) then
                   move.pos = move.pos+self.Entity:GetUp()*-200
               elseif self.Pilot:KeyDown( IN_JUMP ) then
                   move.pos = move.pos+self.Entity:GetUp()*300
				end
            
                if self.Pilot:KeyDown( IN_MOVERIGHT ) then
					move.pos = move.pos+self.Entity:GetRight()*400
				elseif self.Pilot:KeyDown( IN_MOVELEFT ) then
					move.pos = move.pos+self.Entity:GetRight()*-400
				end
			
			
			move.maxangular		= 5000
			move.maxangulardamp	= 10000
			move.maxspeed			= 1000000
			move.maxspeeddamp		= 10000
			move.dampfactor		= 0.8
			move.teleportdistance	= 5000
			local ang = self.Pilot:GetAimVector():Angle()
			move.angle			= ang --+ Vector(90 0, 0)
			move.deltatime		= deltatime
		phys:ComputeShadowControl(move)
	end
end

function ENT:Enabled()
	return false;
end

function ENT:FireWeapon()
	if (StarGate.Installed == true) then
		local pos = self.Entity:GetPos();
		local vel = self.Entity:GetVelocity();
		local up = self.Entity:GetUp();
		local forward = self.Entity:GetForward();

		local offset = StarGate.VelocityOffset({Velocity=vel,Direction=up,BoundingMax=self.Entity:OBBMaxs().z});
		local e = ents.Create("staff_pulse_stationary");
		e.Parent = self.Entity;
		e:SetPos(pos+offset);
		--e:SetAngles(self.Entity:GetForward():Angle()+Angle(math.random(-2,2),math.random(-2,2),math.random(-2,2)));
		e:SetAngles(self.Entity:GetAngles());
		e:SetOwner(self.Entity); 
		e.Owner = self.Entity.Owner;
		e:Spawn();

		e:SetVelocity(vel + (forward*2000));
		e.CannonVelocity = vel;
		self.Entity:EmitSound(Sound("weapons/staff_weapon.mp3"),90,math.random(90,110));
	else
		self.UseWeapon = false
	end

end


function ENT:TriggerInput(k,v)
	if(k=="Disable Weapon") then
		if ((v or 0) >= 1) then
			self.UseWeapon = false
		else
			self.UseWeapon = true
		end
	end
	
	if(k=="Hover") then
		if((v or 0) >= 1) then
			self.Hover=true;
		else
			self.Hover=false;
		end
	end
	
	if(k=="View") then
		if((v or 0) >= 1) then
			self.Entity:SetNetworkedBool("FirstPerson",true)
		else
			self.Entity:SetNetworkedBool("FirstPerson",false)
		end
	end
	
end	


 function ENT:ShowOutput()

end 

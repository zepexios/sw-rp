AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");
SWEP.Sounds = {Shot={Sound("asuran/Ancientstun.wav"),Sound("asuran/Ancientstun.wav")},Deploy=Sound("asuran/dep.wav")};

--################### Init the SWEP @aVoN
function SWEP:Initialize()
	-- Sets how fast and how much shots an NPC shall do
	self:SetNPCFireRate(.5);
	self:SetNPCMinBurst(3);
	self:SetNPCMaxBurst(5);
	self:SetWeaponHoldType("smg1");
end

--################### Initialize the shot @aVoN
function SWEP:SVPrimaryAttack()
	local p = self.Owner;
	local multiply = .3; -- Default inaccuracy multiplier
	local aimvector = p:GetAimVector();
	local shootpos = p:GetShootPos();
	local vel = p:GetVelocity();
	local filter = {self.Owner,self.Weapon};
	-- Add inaccuracy for players!
	if(p:IsPlayer()) then
		local right = aimvector:Angle():Right();
		local up = aimvector:Angle():Up();
		-- Check, how far we can go to right (avoids exploding shots on the wall right next to you)
		local max = util.QuickTrace(shootpos,right*100,filter).Fraction*100 - 10;
		local trans = right:DotProduct(vel)*right/25
		if(p:Crouching()) then
			multiply = 0.3; -- We are in crouch - Make it really accurate!
			-- We need to adjust shootpos or it will look strange
			shootpos = shootpos + math.Clamp(15,-10,max)*right - 4*up + trans;
		else
			-- He stands
			shootpos = shootpos + math.Clamp(23,-10,max)*right - 15*up + trans;
		end
		multiply = multiply*math.Clamp(vel:Length()/500,0.3,3); -- We are moving - Make it inaccurate depending on the velocity
	else -- It's an NPC
		multiply = 0;
	end
	-- Now, we need to correct the velocity depending on the changed shootpos above.
	local trace = util.QuickTrace(p:GetShootPos(),16*1024*aimvector,filter);
	if(trace.Hit) then
		aimvector = (trace.HitPos-shootpos):Normalize();
	end
	-- Add some randomness to the velocity
	local e = ents.Create("ancient_pulse");
	e:SetPos(shootpos);
	e:Spawn();
	e:SetVelocity(aimvector*3500+VectorRand()*multiply); -- Velocity and "randomness"
	e:SetOwner(p);
	e:SetColor(50,255,50,255);
	p:EmitSound(self.Sounds.Shot[math.random(1,#self.Sounds.Shot)],90,math.random(97,103));
	if(self.Owner:IsPlayer()) then self:TakePrimaryAmmo(0) end; -- Take one Ammo
end

--################### Head
SWEP.Category = "SWO"
SWEP.PrintName = "Blaster rifle: green";
SWEP.Author = "Col. Shepard"
SWEP.Contact = "steam:Col. Shepard, Mandalore, mginshe"
SWEP.Purpose = "for use in killing stupid people"
SWEP.Instructions = "aim away from face"
SWEP.Pack = "SWO weaponry"
SWEP.Base = "weapon_base";		
SWEP.Slot = 2;
SWEP.SlotPos = 0;
SWEP.DrawAmmo	= false;
SWEP.DrawCrosshair = false;
SWEP.ViewModel = "models/weapons/v_smg1.mdl";
SWEP.WorldModel = "models/weapons/w_smg1.mdl";

-- primary.
SWEP.Primary.ClipSize = 0;
SWEP.Primary.DefaultClip = 50;
SWEP.Primary.Automatic = true;
SWEP.Primary.Ammo	= "StriderMinigun";

-- secondary
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

-- spawnables.
SWEP.Spawnable = false;
SWEP.AdminSpawnable = true;

-- Add weapon for NPCs
list.Set("NPCWeapons","blaster rifle: green","blaster rifle: green");

--################### Deploy @aVoN
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW); -- Animation
	if SERVER then self.Owner:EmitSound(self.Sounds.Deploy,45) end;
end

--################### Shoot @aVoN
function SWEP:PrimaryAttack()	
	if(not ValidEntity(self.Owner) or (self.Owner:IsPlayer() and self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0)) then return end;
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
	-- Muzzle
	local fx = EffectData();
	fx:SetScale(0);
	fx:SetOrigin(self.Owner:GetShootPos());
	fx:SetEntity(self.Owner);
	fx:SetAngle(Angle(75,255,75));
	fx:SetRadius(50);
	util.Effect("energy_muzzle",fx,true);
	-- Shot
	if SERVER then self:SVPrimaryAttack() end;
	self.Weapon:SetNextPrimaryFire(CurTime()+0.2);
	return true;
end

--Is none atm :D
function SWEP:SecondaryAttack()
end

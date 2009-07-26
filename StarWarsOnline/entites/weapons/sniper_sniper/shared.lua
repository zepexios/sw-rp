// By MGinshe for SnperAttack

SWEP.base 						= "weapon_base"
SWEP.Category 					= "SniperAttack"
SWEP.Author 					= "MGinshe"
SWEP.Contact 					= "MGinshe@hotmail.com"
SWEP.Purpose 					= "Sniper needs a sniper.. Duh!"
SWEP.Instructions 				= "Click to shoot, Right click to zoom (8x to 16x)"
SWEP.PrintName 					= "Sniper"
SWEP.Slot 						= 3
SWEP.SlotPos					= 1
SWEP.DrawCrosshair 				= true
SWEP.DrawAmmo 					= true
SWEP.ViewModel 					= "models/weapons/v_pistol.mdl"
SWEP.WorldModel 				= "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV 				= 64
SWEP.ReloadSound 				= ""
SWEP.HoldType 					= "pistol"
SWEP.Spawnable 					= true
SWEP.AdminSpawnable				= true
SWEP.Weight 					= 1
SWEP.AutoSwitchTo 				= false
SWEP.AutoSwitchFrom 			= true
SWEP.FiresUnderwater 			= true
Zoom							= 1

SWEP.Primary.Sound 				= "weapon_AWP.Single"
SWEP.Primary.Tracer 			= 1
SWEP.Primary.Automatic 			= false
SWEP.Primary.Force 				= 10
SWEP.Primary.FireFromHip 		= true
SWEP.Primary.Weld 				= false
SWEP.Primary.Ammo 				= "smg1"
SWEP.Primary.Ignite 			= false
SWEP.Primary.ClipSize			= 10
SWEP.Primary.DefaultClip 		= 100
SWEP.Primary.Recoil 			= 0.7
SWEP.Primary.Damage 			= 70
SWEP.Primary.NumberofShots 		= 1
SWEP.Primary.Spread 			= 0.0
SWEP.Primary.Delay 				= 0.6
SWEP.Primary.TakeAmmo 			= 1

SWEP.Secondary.Sound 			= ""
SWEP.Secondary.Tracer 			= 0
SWEP.Secondary.Force 			= 0
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.FireFromHip 		= false
SWEP.Secondary.Weld				= false
SWEP.Secondary.Ignite 			= false
SWEP.Secondary.Recoil 			= 0
SWEP.Secondary.Spread 			= 0
SWEP.Secondary.Delay 			= 0
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip 		= -1

if( SERVER ) then
	AddCSLuaFile( 'shared.lua' )
end

function SWEP:Initialize()
    util.PrecacheSound( self.Primary.Sound )
    if ( SERVER ) then
       self:SetWeaponHoldType( self.HoldType )
   end
end

function SWEP:PrimaryAttack()
	if( !self:CanPrimaryAttack() ) then return end
	
	local trace = self.Owner:GetEyeTrace()
	self.Weapon:EmitSound ( self.Primary.Sound )
	self:ShootEffects()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	local rnda = -self.Primary.Recoil
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	
	local Bullet = {}
    Bullet.Num = self.Primary.NumberofShots
    Bullet.Src = self.Owner:GetShootPos()
    Bullet.Dir = self.Owner:GetAimVector()
    Bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    Bullet.Tracer = self.Primary.Tracer
    Bullet.Force = self.Primary.Force
    Bullet.Damage = self.Primary.Damage
    Bullet.AmmoType = self.Primary.Ammo
    self.Owner:FireBullets( Bullet )
end

function SWEP:SecondaryAttack()
	
	if( Zoom == 1 ) then
		self.Owner:SetFOV( 20, 0 )
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Zoom level 2" )
		Zoom = 2
	elseif( Zoom == 2 ) then
		self.Owner:SetFOV( 10, 0 )
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Zoom level 3" )
		Zoom = 3
	elseif( Zoom == 3 ) then
		self.Owner:SetFOV( 0, 0 )
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Zoom level 1" )
		Zoom = 1
	end
end

function SWEP:Reload()
	self.Weapon:EmitSound( "weapon_pistol.Reload" )
	self.Owner:SetFOV( 0, 0 )
	Zoom = 1
	self.Weapon:DefaultReload( ACT_VM_RELOAD )
	return true
end

function SWEP:Deploy()
   self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
   return true
end

function SWEP:Holster()
   return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

// By MGinshe for SniperAttack

SWEP.base 						= "weapon_base"
SWEP.Category 					= "SniperAttack"
SWEP.Author 					= "MGinshe"
SWEP.Contact 					= "MGinshe@hotmail.com"
SWEP.Purpose 					= "All sniper need a secondary!"
SWEP.Instructions 				= "Click to shoot, Right click to change FireModes"
SWEP.PrintName 					= "pistol"
SWEP.Slot 						= 2
SWEP.SlotPos					= 1
SWEP.DrawCrosshair 				= true
SWEP.DrawAmmo 					= true
SWEP.ViewModel 					= "models/weapons/v_pistol.mdl"
SWEP.WorldModel 				= "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV 				= 64
SWEP.ReloadSound 				= "weapons/pistol/pistol_reload1"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable 					= true
SWEP.AdminSpawnable				= true
SWEP.Weight 					= 1
SWEP.AutoSwitchTo 				= false
SWEP.AutoSwitchFrom 			= true
SWEP.FiresUnderwater 			= true
FireMode						= 1

SWEP.Primary.Sound 				= "weapon_357.Single"
SWEP.Primary.Tracer 			= 1
SWEP.Primary.Automatic 			= false
SWEP.Primary.Force 				= 2
SWEP.Primary.FireFromHip 		= true
SWEP.Primary.Weld 				= false
SWEP.Primary.Ammo 				= "pistol"
SWEP.Primary.Ignite 			= false
SWEP.Primary.ClipSize			= 12
SWEP.Primary.DefaultClip 		= 120
SWEP.Primary.Recoil 			= 0.7
SWEP.Primary.Damage 			= 20
SWEP.Primary.NumberofShots 		= 1
SWEP.Primary.Spread 			= 0.0
SWEP.Primary.Delay 				= 0.1
SWEP.Primary.TakeAmmo 			= 1

SWEP.Secondary.Sound 			= "weapon_pistol.Empty"
SWEP.Secondary.Tracer 			= 0
SWEP.Secondary.Force 			= 0
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.FireFromHip 		= false
SWEP.Secondary.Weld				= false
SWEP.Secondary.Ignite 			= false
SWEP.Secondary.Recoil 			= 0
SWEP.Secondary.Spread 			= 0
SWEP.Secondary.Delay 			= 0.3
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip 		= -1

if( SERVER ) then
	AddCSLuaFile( 'shared.lua' )
end

function SWEP:Initialize()
    util.PrecacheSound( self.Primary.Sound )
    util.PrecacheSound( self.Secondary.Sound )
    if ( SERVER ) then
       self:SetWeaponHoldType( self.HoldType )
   end
end

function SWEP:PrimaryAttack()
	if( !self:CanPrimaryAttack() ) then return end
	
	local trace = self.Owner:GetEyeTrace()
	self:ShootEffects()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	local rnda = -self.Primary.Recoil
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	
	if( FireMode == 1 ) then
		self.Weapon:EmitSound ( self.Primary.Sound )
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
	if( FireMode == 2 ) then
		self.Weapon:EmitSound ( self.Primary.Sound )
		local IncendiaryBullet = {}
        IncendiaryBullet.Num = self.Primary.NumberofShots
        IncendiaryBullet.Src = self.Owner:GetShootPos()
        IncendiaryBullet.Dir = self.Owner:GetAimVector()
        IncendiaryBullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
        IncendiaryBullet.Tracer = self.Primary.Tracer
        IncendiaryBullet.Force = self.Primary.Force
        IncendiaryBullet.Damage = self.Primary.Damage - 10
        IncendiaryBullet.AmmoType = self.Primary.Ammo
        self.Owner:FireBullets( IncendiaryBullet )
		
		if( ( trace.Entity and trace.Entity:IsValid() ) or ( trace.Entity:IsPlayer() ) ) then
			if( CLIENT ) then return end
			local Time = math.random( 1, 10 )
			trace.Entity:Extinguish()
			trace.Entity:Ignite( Time, 0 )
		end
	end
	if( FireMode == 3 ) then
		self.Weapon:EmitSound ( "weapons/pistol/pistol_fire1" )
		local SilentBullet = {}
        SilentBullet.Num = self.Primary.NumberofShots
        SilentBullet.Src = self.Owner:GetShootPos()
        SilentBullet.Dir = self.Owner:GetAimVector()
        SilentBullet.Spread = Vector( 0.3 * 0.1 , 0.3 * 0.1, 0)
        SilentBullet.Tracer = self.Primary.Tracer
        SilentBullet.Force = self.Primary.Force
        SilentBullet.Damage = self.Primary.Damage + 10
        SilentBullet.AmmoType = self.Primary.Ammo
        self.Owner:FireBullets( SilentBullet )
	end
end

function SWEP:SecondaryAttack()
	
	if( FireMode == 3 ) then
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Normal rounds enabled." )
		FireMode = 1
		self.Weapon:EmitSound ( self.Secondary.Sound )
	elseif( FireMode == 1 ) then
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Incendiary rounds enabled." )
		FireMode = 2
		self.Weapon:EmitSound ( self.Secondary.Sound )
	elseif( FireMode == 2 ) then
		self.Owner:PrintMessage( HUD_PRINTCENTER, "High Powered rounds enabled." )
		FireMode = 3
		self.Weapon:EmitSound ( self.Secondary.Sound )
	end
end

function SWEP:Reload()
	self.Weapon:EmitSound( "weapon_pistol.Reload" )
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

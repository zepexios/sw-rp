--test to get svn to update
include("shared.lua");
-- Inventory Icon
if(file.Exists("../materials/weapons/asuran_inventory.vmt")) then
	SWEP.WepSelectIcon = surface.GetTextureID("weapons/asuran_inventory");
end
-- Kill Icon
if(file.Exists("../materials/weapons/asuran_inventory.vmt")) then
	killicon.Add("weapon_ancient","weapons/asuran_killicon",Color(255,255,255));
end
language.Add("Striderminigun_ammo","Anicent Pulse Ammo");
language.Add("weapon_ancient","Ancient Gun");

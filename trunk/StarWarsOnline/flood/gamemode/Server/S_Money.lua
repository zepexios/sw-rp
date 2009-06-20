-----------------------------
-- Flood By iRzilla
-----------------------------
-- Server/S_Money.lua

hook.Add( "PlayerInitialSpawn", "FL.playerInitialSpawn", function(ply) ply:Load() end )

local Meta = FindMetaTable("Player")

function Meta:Load()
  if self:IsValid() then
	local CashFile = "FloodCashLogs/" .. self:UniqueID() .. ".txt"

	if file.Exists("FloodWeapons/"..string.Replace(self:SteamID(),":","_")..".txt") then
		local In = file.Read("FloodWeapons/"..string.Replace(self:SteamID(),":","_")..".txt")
		In = string.Explode("\n",In)
		self.Weapons = In;
		self.WepLoad = true
	else
		self.Weapons = {}
		table.insert(self.Weapons, "weapon_pistol")
		local Out = string.Implode("\n",self.Weapons)
		file.Write("FloodWeapons/"..string.Replace(self:SteamID(),":","_")..".txt",Out)
		self.WepLoad = true
	end

	if file.Exists(CashFile) then
		self:SetNWInt("Cash", tonumber(file.Read(CashFile)))
		self.CashLoad = true
	else
		file.Write(CashFile, 1000)
		self:SetNWInt("Cash", 1000)
		self.CashLoad = true
	end
	
	if self.WepLoad and self.CashLoad then
		self:PrintMessage(HUD_PRINTCENTER, "Profile sucessfully loaded.")
		self.Allow = true
	else
		self:PrintMessage(HUD_PRINTCENTER, "Profile load failed, please rejoin or contact an admin.")
	end
  end
end

function Meta:SetCash(ammount)
	return self:SetNWInt("Cash", ammount)
end

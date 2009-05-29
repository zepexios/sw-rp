local FName = "Test"
--[[
function SWPlayerData( ToDo, table, FileName )
	if(ToDO == "WirteTable") then
		local SaveTable =
	end

	if(ToDo == "ReadTable") then
		if(file.Exists("UserData/Data.txt")) then
		local ReadTable = file.Read("UserData/Data.txt")
		table = util.KeyValuesToTable(ReadTable)
		end
	return LoadTab
	end
end
]]
function SWGetData( Type )
	if( Type == "Name" ) then
	return "MGinshe"
	elseif( Type == "Money" )then
	return 10000
	elseif( Type == "Team" )then
	return "Merc's"
	elseif( Type == "Class" )then
	return "Jedi"
	elseif( Type == "CombatLvl" )then
	return 74
	elseif( Type == "CombatXP" )then
	return SWGetData( "CombatLvl" ) /2 /2 /2 *(SWGetData( "CombatLvl" ) * 100)
	elseif( Type == "TCombatXP" )then
	return -1
	elseif( Type == "RifleLvl" )then
	return 76
	elseif( Type == "RifleXP" )then
	return SWGetData( "RifleLvl" ) /2 /2 /2 *(SWGetData( "RifleLvl" ) * 100)
	elseif( Type == "TRifleXP" )then
	return -1
	elseif( Type == "SaberLvl" )then
	return 75
	elseif( Type == "SaberXP" )then
	return SWGetData( "SaberLvl" ) /2 /2 /2 *(SWGetData( "SaberLvl" ) * 100)
	elseif( Type == "TSaberXP" )then
	return 10000
	else
	return "Undefined"
	end
end
DataTable = {
	Name = SWGetData( "Name" ),
	Money = SWGetData( "Money" ),
	Team = SWGetData( "Team" ),
	Class = SWGetData( "Class" ),
	CombatLvl = SWGetData( "CombatLvl" ),
	CombatXP = SWGetData( "ComabtXP" ),
	TotalCombatXP = SWGetData( "TCombatXP" ),
	RifleLvl = SWGetData( "RifleLvl" ),
	RifleXP = SWGetData( "RifleXP" ),
	TotalRifleXP = SWGetData( "TRifleXP" ),
	SaberLvl = SWGetData( "SaberLvl" ),
	SaberXP = SWGetData( "aberXP" ),
	TotalSaberXP = SWGetData( "TSaberXP" ),
	}
for k,v in pairs(DataTable) do
	print(k..": "..v)
end



















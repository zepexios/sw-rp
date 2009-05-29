local FName = "Test"
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
function SWData( Type )
	if(Type != (Set ||) then
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



















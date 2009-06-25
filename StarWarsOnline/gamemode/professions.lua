// Professions.lua by MGinshe
// This is gona be big, so i have implemented a "plugin" system.
// Add a file to the "Professions" Folder to add a profession
// P.S Take a look at "Prof_Tamplate.lua" For an example of how to make Professions :)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This is the plugin system ------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Set up the global table FIRST!
Prof = Prof or {}

function Profs:LoadProfs( ply )
	Prof:Init()
	Fails = 0
	Works = 0	
	print( "*************************************" )
	print( "********Loading Professions**********" )
	for _,v in pairs(file.FindInLua("Professions/Prof_*.lua")) do
			Fails = Fails + Failed
			Works = Works + Worked
			include("Professions/"..v)
			local Status, Failed, Worked = Prof:Init()
			local Name = string.sub( v, 1, 5 )
			local ProfName = string.sub( Name, -4 )
			print( "Profession: \""ProfName"\" "..Status )
	end
	print( "Modules Loaded: "..Works )
	print( "Modules Failed: "..Works )
	print( "*********Loading Finished!***********" )
	print( "*************************************" )
end






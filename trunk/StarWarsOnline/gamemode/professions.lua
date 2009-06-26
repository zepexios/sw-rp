// Professions.lua by MGinshe
// This is gona be big, so i have implemented a "plugin" system.
// Add a file to the "Professions" Folder to add a profession
// P.S Take a look at "Prof_Tamplate.lua" For an example of how to make Professions :)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This is the plugin system ------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Prof = Prof or {}

function Prof:LoadProfs( ply ) 
	Fails = 0
	Works = 0	
	print( "*************************************" )
	print( "********Loading Professions**********" )
	for _, v in pairs( file.FindInLua( "Professions/*.lua" ) do
		include('Professions/'..v)
		Status, ProfName = Init()
		print( "Profession: \""..ProfName.."\" "..Status )
		if( Status = "Loaded" || "loaded" ) then
			Works = Works + 1
		else
			Fails = Fails + 1
		end
	end
	print( "Modules Loaded: "..Works )
	print( "Modules Failed: "..Works )
	print( "*********Loading Finished!***********" )
	print( "*************************************" )
end


// Name = string.sub( v, 1, 5 )
// = string.sub( Name, -4 )
// 122.58.67.128:27015
SWO.Classes = {}

function SWO:LoadClasses( Dir )
	Dir = Dir or "Server/Classes"
	SWO.Msg( "Loading Classes From: "..Dir )
	for k, File in pairs( file.FindInLua( "../gamemodes/StarWarsOnline/gamemode".."/"..Dir.."/*.lua" ) ) do
		pcall( include, Dir.."/"..File )
		SWO.Msg( "Class: "..File.." Loaded" )
	end
	
	SWO.Msg( "Finished Loading Classes" )
end

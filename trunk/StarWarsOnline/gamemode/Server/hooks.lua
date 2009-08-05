function GM:PlayerInitialSpawn( ply )
	ply:LoadChars()
	ply:ConCommand( "OpenCharSelection" )
	
	ply:PrintMessage( HUD_PRINTTALK, "Hey "..ply:Nick().."!" )
	ply:PrintMessage( HUD_PRINTTALK, "Welcome to SWO's official Server." )
	ply:PrintMessage( HUD_PRINTTALK, "Type \"!info\" for player info." )
end

function GM:PlayerSpawn( ply )

	util.PrecacheModel( ply.Char.Model )
	ply:SetModel( ply.Char.Model )
	ply:SetNWInt( "PlayerForce", ply:GetForce() )
	ply:SetNWInt( "PlayerMaxForce", ply:GetMaxForce() )
	ply:AddForce( ply:GetMaxForce() )
	
end

function GM:PlayerLoadout(ply)

	ply:GiveAllWeapons()
	ply:GiveAllAmmo()
	
end
function GM:AcceptStream ( pl, handler, id )

    return true
	
end
function GM:ShowHelp( ply )

	ply:ConCommand( "OpenCharSelection" ) // Thanks Autopsy
	
end 

// Timers
local songs = {"imperial.mp3", "duel.mp3", "heroes.mp3","luke.mp3","force.mp3","anakin.mp3"}

function PlayTehSongs()
	timer.Simple(300,function() PlayTehSongs() end)
	song = table.Random(songs)
	print("Playing Song: "..song)
	for k, v in pairs( player.GetAll() ) do
		v:EmitSound( song )
	end
end
timer.Simple(1,function() if( PlayeSongs ) then PlayTehSongs() end end)

SWO.LoadPROFs()
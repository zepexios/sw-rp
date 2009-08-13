function GM:PlayerInitialSpawn( ply )
	ply:LoadChars()
	
	ply:PrintMessage( HUD_PRINTTALK, "Hello "..ply:Nick().."!" )
	ply:PrintMessage( HUD_PRINTTALK, "Welcome to SWO's official Server." )
end

function GM:PlayerSpawn( ply )
	--check to see if player has joined before and have a Char table
	if ply.Char == nil then ply.Char = {}; end
	--@meeces2911, change this to refer to a default model setting somewhere
	if ply.Char.Model == nil then ply.Char.Model = "models/player/alyx.mdl"; end

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

function GM:PlayerBindPress( ply, BIND, pressed )	// Blocks ConCommands; Add a new line with the format below to block a Cmd ..MGinshe..
	if( string.find( BIND, "<Command>" ) ) then return false end
	if( string.find( BIND, "kill" ) ) then ply:PrintMessage( HUD_PRINTCONSOLE, "Suicice is NOT the way!" ) end
end

function GM:KeyPress( ply, KEY )
	if( KEY == IN_WALK ) then
		ply:ConCommand( "+MouseInput" )
	end
end

function GM:KeyRelease( ply, KEY )
	if( KEY == IN_WALK ) then
		ply:ConCommand( "-MouseInput" )
	end
end

function GM:CanPlayerSuicide( ply )
	return false
end

function GM:AcceptStream ( pl, handler, id )
    return true
end

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
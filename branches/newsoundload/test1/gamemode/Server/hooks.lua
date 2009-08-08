function GM:PlayerInitialSpawn( ply )
	ply:LoadChars()
	ply:ConCommand( "OpenCharSelection" )
	
	ply:PrintMessage( HUD_PRINTTALK, "Hey "..ply:Nick().."!" )
	ply:PrintMessage( HUD_PRINTTALK, "Welcome to SWO's official Server." )
	ply:PrintMessage( HUD_PRINTTALK, "Type \"!info\" for player info." )
	
end

function GM:PlayerSpawn( ply )

	
	--check to see if player has joined before and have a Char table
	--Nows clientside files are fixed, this should never be used again.
	if ply.Char == nil then ply.Char = {}; end
	--@meeces2911, change this to refer to a default model setting somewhere
	if ply.Char.model == nil then ply.Char.model = "models/player/alyx.mdl"; end

	util.PrecacheModel( ply.Char.model )
	ply:SetModel( ply.Char.model )
	ply:SetNWInt( "PlayerForce", ply:GetForce() )
	ply:SetNWInt( "PlayerMaxForce", ply:GetMaxForce() )
	ply:AddForce( ply:GetMaxForce() )
	ply:AddXP(0) --make sure XP is set.
	
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
function GM:GetFallDamage( ply, fspeed )
	if ply.NoFallDamage then
		return false
	else
		return ( fspeed / 8 )
	end 
end

function SWOSKill(ply)
	if ply:Alive() then
		ply:KillSilent()
	else
		ply:Spawn()
	end
end
concommand.Add("SWOSKill",SWOSKill)

// Timers
--@meeces2911
-- I dont like this, i think you sould have the server call a client command to play the songs, and to check if the sound files are valid first.
-- But anyway i have update the sound paths to work with the new system.
local songs = {"SWO/client/imperial.mp3", "SWO/client/duel.mp3", "SWO/client/heroes.mp3","SWO/client/luke.mp3","SWO/client/force.mp3","SWO/client/anakin.mp3"}

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
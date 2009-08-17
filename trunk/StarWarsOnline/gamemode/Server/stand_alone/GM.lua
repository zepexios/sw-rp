function GM:PlayerInitialSpawn( ply )
	--Scrapped, Add new function here!
	--ply:LoadChars()
	
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
	
end

function GM:PlayerLoadout(ply)

	ply:GiveAllWeapons()
	ply:GiveAllAmmo()
	
end

--Moved GM:PlayerBindPress as its a client side function (DONT know why... it shouldn't be :(  ) its now in shared/GM.lua
--MG remove this comment when you see it. I just put this here, just in case you didn't read the change log :P

function GM:KeyPress( ply, KEY )
	if( KEY == IN_WALK ) then
		ply:ConCommand( "MouseInput" )
	end
end

function GM:KeyRelease( ply, KEY )
	if( KEY == IN_WALK ) then
		ply:ConCommand( "MouseInput" )
	end
end

function GM:CanPlayerSuicide( ply )
	if SWO.DebugMode then return true end
	ply:PrintMessage( HUD_PRINTCONSOLE , "Suicice is NOT the way!" )
	ply:PrintMessage( HUD_PRINTTALK , "Suicice is NOT the way!" )
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
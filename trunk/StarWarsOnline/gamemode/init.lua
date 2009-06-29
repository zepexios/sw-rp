--[[------------------------NOTE----------------------------------
	Polkm: This file is for functions that are called for the gamemode
--------------------------NOTE----------------------------------]]

------------------------------------------------------------
require("datastream")

------------------------------------------------------------
--AddCSLuaFile is for files that the client needs to download
--ie: any thing client side or shared

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('cl_charbox.lua')
AddCSLuaFile('cl_vgui.lua')
AddCSLuaFile('cl_hud.lua')
AddCSLuaFile('shared.lua')
AddCSLuaFile('professions.lua')

------------------------------------------------------------
include('shared.lua')
include('quests.lua')
include('level.lua')
include('player_extention.lua')
include('level.lua')
include('resource.lua')
include('sv_effects.lua')
include('professions.lua')

--Player Spawning----------------------------------------------------------
--This function is called once on the first time you spawn
function GM:PlayerInitialSpawn(ply)
	ply:LoadChars()
	ply:ConCommand("OpenCharSelection")
	
	ply:PrintMessage(HUD_PRINTTALK, "Hey "..ply:Nick().."!")
	ply:PrintMessage(HUD_PRINTTALK, "Welcome to SWO's official Server.")
	-- ply:PrintMessage(HUD_PRINTTALK, "Type \"!info\" for Your player info.")
end
--Polkm: This is called everytime you spawn
function GM:PlayerSpawn(ply)
	ply:SetRunSpeed( 1000 )
	ply:SetModel( "models/alyx.mdl" )
	ply:Give( "weapon_smg1" )
	ply:Give( "weapon_rpg" )
end
--Polkm: This is called to give players weapons
function GM:PlayerLoadout(ply)

end
--iRzilla: Allows clients to send server big tables.
function GM:AcceptStream ( pl, handler, id )
     return true
end

--Autopsy Added This Below
--It Add's The F1 Bind


 function GM:ShowHelp( ply )
   ply:ConCommand( "OpenCharSelection" )
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
timer.Simple(1,function() PlayTehSongs() end)

SWO_LoadPROFs()









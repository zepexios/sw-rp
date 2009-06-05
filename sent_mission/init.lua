AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 30

	local ent = ents.Create( "sent_mission" ) -- NAME OF THE FOLDER eg: sent_zombie_spawn
	ent:SetPos( SpawnPos )
	ent:Spawn()
	return ent
end

function ENT:Initialize()
self.Entity:SetModel( "models/props_combine/breenconsole.mdl" )
self:SetHealth(10000000000000000000000000000000000000000000000000000)
end

function ENT:Use( activator, caller )

if (activator:IsPlayer() ) then
function OpenQuestScreen()
QuestScreenIsOpen = true
Quest = vgui.Create("DPanel")
Quest:SetSize(200, ScrH() - 10)
Quest:SetTitle("Mission Terminal")
Quest:SetPos(50, 50)
Quest:ShowClostButton( true )
Quest:SetDraggable( false )
Quest:MakePopup( true )
print( "work" )
end
end
end




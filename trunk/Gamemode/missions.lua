
function Useing(ply, ent)
  if not( ValidEntity( ply ) ) then return end
  if( ent:GetClass() == "ent_stormtrooper" ) then
local DermaPanel = vgui.create( "DFrame" )
DermaPanel:SetPos( 50, 50 )
DermaPanel:SetSize( 150, 200 )
DermaPanel:SetTitle( "Mission Terminal" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( false )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup() 			 
			 
  end
end
hook.Add("PlayerUse", "MyUseHook", Useing)

//im goingto see why this isnt wkoring. mabe you implemented the table wrong?
//yep... : ) fixed

QUESTS[KillGMan] = {} // [QUESTS} is nil?
QUESTS.KillGMan[Reward] = 3000
QUESTS.KillGMan[DoneIt] = function(victim, killer)
	if victim:GetClass() == "npc_gman" and killer:IsPlayer() then
		Msg("YOU KILLED GMAN AND GOT: "..QUESTS["Kill GMAN"].Reward.." Credits.") // doesnt work right now
	end
end

hook.Add( "OnNPCKilled"	, "KillGman", QUESTS.KillGMan.DoneIt)

CUSTOMNPC = {}

-- Example Quest
CUSTOMNPC["example"] = {}
CUSTOMNPC["example"].name = "Ex. Ample"
CUSTOMNPC["example"].quests = {"quest_example_one", "quest_example_two" }
CUSTOMNPC["example"].position = Vector(1200.405151, 383.012970, 95.031250) -- VECTOR // Unsure if this works but a more indepth quest system = D
CUSTOMNPC["example"].model = nil --"models/port1.mdl"
CUSTOMNPC["example"].OnSpawn =	function()
							--What happens when the NPC spawns
							end
CUSTOMNPC["example"].OnKill =		function()
							--What happens when the NPC spawns
							end
CUSTOMNPC["example"].OnInteract = function()
							--What happens when the NPC spawns
							end



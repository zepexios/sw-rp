
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

QUESTS["Kill GMAN"] = {}
QUESTS["Kill GMAN"].Reward = 3000
QUESTS["Kill GMAN"].DoneIt = function(victim, killer)
	if victim:GetClass() == "npc_gman" and killer:IsPlayer() then
		Msg("YOU KILLED GMAN AND GOT: "..QUESTS["Kill GMAN"].Reward.." Credits.")
	end
end

hook.Add( "OnNPCKilled"	, "LOLLOLKILLGMANUNIQUENAMEIWIN", QUESTS["Kill GMAN"].DoneIt)

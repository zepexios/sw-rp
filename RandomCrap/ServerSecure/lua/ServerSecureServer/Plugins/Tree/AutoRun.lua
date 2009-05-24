// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Tree

local Plugin = SS.Plugins:New("Tree")

Plugin.Trees = {}

// Tree command

local Tree = SS.ChatCommands:New("Tree")

SS.Flags.Branch("Server", "Tree")

function Tree.Command(Player, Args)
	SS.PlayerMessage(0, Player:Name().." has planted a "..SS.Config.Request("Points Name").." tree!", 0)
	
	local Trace = Player:ServerSecureTraceLine()
	
	local Tree = ents.Create("prop_physics")
	
	Tree:SetModel("models/props/cs_militia/tree_large_militia.mdl")
	Tree:SetPos(Trace.HitPos)
	Tree:Spawn()
	
	// PropSecure should pick this up too
	
	Player:AddCleanup("props", Tree)
	
	Player:AddCount("props", Tree)
	
	// Undo
	
	undo.Create("prop")
		undo.AddEntity(Tree)
		undo.SetPlayer(Player)
	undo.Finish()
	
	// Add it to the trees list
	
	local Index = Tree:EntIndex()
	
	Plugin.Trees[Index] = {Tree, RealTime() + Args[2], Args[1], Args[2], Player}
	
	// Physics
	
	local Phys = Tree:GetPhysicsObject():EnableMotion(false)
	
	// Effect
	
	local Effect = EffectData()
	
	Effect:SetEntity(Tree)
	Effect:SetOrigin(Tree:GetPos())
	Effect:SetStart(Tree:GetPos())
	Effect:SetScale(500)
	Effect:SetMagnitude(250)
	
	util.Effect("ThumperDust", Effect)
end

Tree:Create(Tree.Command, {"Server", "Tree"}, "Spawn a tree that drops points", "<Amount> <Time>", 2, " ")

// Think

function Plugin.ServerSecond()
	for K, V in pairs(Plugin.Trees) do
		if (SS.Lib.Valid(V[1])) then
			if (RealTime() > V[2]) then
				local Entity = ents.Create("Points")
				
				// Variables
				
				Entity:SetPos(V[1]:GetPos() + Vector(math.random(-64, 64), math.random(-64, 64), 64))
				Entity:SetNetworkedInt("Points", V[3])
				Entity:Spawn()
				
				// Connected
				
				if (V[5]:IsConnected()) then
					Entity:SetPlayer(V[5])
					
					// Cleanup
					
					V[5]:AddCleanup("props", Entity)
					V[5]:AddCount("props", Entity)
				end
				
				// Effect
				
				local Effect = EffectData()
				
				Effect:SetEntity(V[1])
				Effect:SetOrigin(V[1]:GetPos())
				Effect:SetStart(V[1]:GetPos())
				Effect:SetScale(9999)
				Effect:SetMagnitude(250)
				
				util.Effect("WaterSplash", Effect)
				
				// Update timer
				
				V[2] = RealTime() + V[4]
			end
		else
			Plugin.Trees[K] = nil
		end
	end
end

// Create

Plugin:Create()
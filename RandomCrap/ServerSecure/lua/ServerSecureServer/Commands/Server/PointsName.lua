// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Points name

local PointsName = SS.ChatCommands:New("PointsName")

// Branch flag

SS.Flags.Branch("Server", "PointsName")

// Points name command

function PointsName.Command(Player, Args)
	local Backup = SS.Config.Request("Points Name")
	
	// New
	
	local New = table.concat(Args, " ")
	
	// Change config
	
	SS.Config.New("Points Name", New)
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		SS.Player.PlayerUpdateGUI(V)
	end
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." changed "..Backup.." to "..SS.Config.Request("Points Name").."!", 1)
end

PointsName:Create(PointsName.Command, {"Server", "PointsName"}, "Change the name of the points", "<Name>", 1, " ")
// Configure

local Command = SS.ChatCommands:New("Configure")

// Branch flag

SS.Flags.Branch("Server", "Configure")

// Configure command

function Command.Command(Player, Args)
	SS.Plugins.Configure(Player)
end

Command:Create(Command.Command, {"Configure", "Server"}, "Configure the plugins on the server")

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."configure to disable/enable plugins on the server")
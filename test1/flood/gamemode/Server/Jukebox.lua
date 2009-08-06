function OpenAllPlayersMusic(ply, command, args)
	umsg.Start("Jukebox.Panel", ply)
	umsg.Long( args[1] )
	umsg.String( "LOL LOL" )
	umsg.String( "10" )
	umsg.End()
end
concommand.Add("OpenDJ", OpenAllPlayersMusic)
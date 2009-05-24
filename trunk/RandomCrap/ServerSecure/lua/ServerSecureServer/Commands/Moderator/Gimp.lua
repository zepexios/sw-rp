// Gimp

local Gimp = SS.ChatCommands:New("Gimp")

// Branch flag

SS.Flags.Branch("Moderator", "Gimp")

// Tables

Gimp.Phrases = {}

// Phrases

Gimp.Phrases[1] = "A gimp is for life, not just for christmas :)"
Gimp.Phrases[2] = "I am gimped!"
Gimp.Phrases[3] = "I am an annoying faggot :D"
Gimp.Phrases[4] = "I suck :)"

// Gimp command

function Gimp.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Gimp")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// TVAR
		
		TVAR.New(Person, "Gimped", false)
		
		// Bool
		
		local Bool = SS.Lib.StringBoolean(Args[2])
		
		// Update
		
		TVAR.Update(Person, "Gimped", Bool)
		
		// Args
		
		if (Bool) then
			SS.PlayerMessage(0, Player:Name().." has gimped "..Person:Name().."!", 0)
		else
			SS.PlayerMessage(0, Player:Name().." has ungimped "..Person:Name().."!", 0)
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Player says something

function Gimp.PlayerTypedText(Player, Text)
	if (TVAR.Request(Player, "Gimped")) then
		local Random = SS.Lib.RandomTableEntry(Gimp.Phrases)
		
		// Return
		
		Player:SetTextReturn(Random, 5)
	end
end

SS.Hooks.Add("Gimp.PlayerTypedText", "PlayerTypedText", Gimp.PlayerTypedText)

// Create

Gimp:Create(Gimp.Command, {"Moderator", "Gimp"}, "Gimp a specific player", "<Player> <1-0>", 2, " ")
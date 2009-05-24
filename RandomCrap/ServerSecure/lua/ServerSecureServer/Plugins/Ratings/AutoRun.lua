// Ratings

SS.Ratings = SS.Plugins:New("Ratings")

// Tables

SS.Ratings.List = {}

// Add a rating

function SS.Ratings.Add(ID)
	table.insert(SS.Ratings.List, ID)
end

// Rate

SS.Ratings.Command = SS.ChatCommands:New("Rate")

// Table

SS.Ratings.Command.Table = {}

// Rate console command

function SS.Ratings.Command.Console(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	local Rating = Args[2]
	
	if (Person) then
		if (Person == Player) then SS.PlayerMessage(Player, "You cannot rate yourself!", 1) return end
		
		// Exists
		
		if not (SS.Ratings.Command.Table[Player]) then
			SS.Ratings.Command.Table[Player] = {}
			
			SS.Ratings.Command.Table[Player][Person] = RealTime() - 1
		end
		
		// Time
		
		if not (SS.Ratings.Command.Table[Player][Person]) then
			SS.Ratings.Command.Table[Player][Person] = RealTime() - 1
		end
		
		// Time
		
		if (SS.Ratings.Command.Table[Player][Person] < RealTime()) then
			if (SS.Ratings.Rate(Player, Person, Rating)) then
				SS.Ratings.Command.Table[Player][Person] = RealTime() + SS.Ratings.Delay
			end
		else
			SS.PlayerMessage(Player, "You cannot rate this person again so soon!", 1)
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

SS.ConsoleCommands.Simple("ratecommand", SS.Ratings.Command.Console, 2, ", ")

// Chat command

function SS.Ratings.Command.Command(Player, Args)
	local Index = Args[1]
	
	local Rating = table.concat(Args, " ", 2)
	
	Player:ConCommand('ss ratecommand '..Index..', '..Rating..'\n')
end

SS.Ratings.Command:Create(SS.Ratings.Command.Command, {"Basic"}, "Rate a specific player", "<Player> <Rating>", 2, " ")

// Config

include("Config.lua")

// When a players variables get set

function SS.Ratings.PlayerSetVariables(Player)
	CVAR.New(Player, "Ratings", {})
end

// When a players GUI gets updated

function SS.Ratings.PlayerUpdateGUI(Player)
	Player:SetNetworkedString("Rating", "Rating: "..SS.Ratings.Rating(Player))
end

// Largest rating

function SS.Ratings.Rating(Player)
	local Size = 0
	
	local Rating = "None"
	
	local Real = "None"
	
	if not (Player:IsPlayerReady()) then return "None" end
	
	// Most
	
	for K, V in pairs(CVAR.Request(Player, "Ratings")) do
		if (V > Size) then
			Size = V
			
			Rating = K.." ("..Size..")"
			
			Real = K
		end
	end
	
	// Search
	
	for K, V in pairs(SS.Ratings.List) do
		if (string.lower(V) == string.lower(Real)) then
			Rating = V.." ("..Size..")"
		end
	end
	
	return Rating
end

// Rate a player

function SS.Ratings.Rate(Player, Person, Rating)
	local Found = false
	
	for K, V in pairs(SS.Ratings.List) do
		if (string.lower(V) == string.lower(Rating)) then
			Found = V
		end
	end
	
	// Not found
	
	if not (Found) then SS.PlayerMessage(Player, "The rating "..Rating.." could not be found", 1) return false end
	
	// Add it
	
	CVAR.Request(Person, "Ratings")[Found] = CVAR.Request(Person, "Ratings")[Found] or 0
	
	local Plus = CVAR.Request(Person, "Ratings")[Found] + 1
	
	CVAR.Request(Person, "Ratings")[Found] = Plus
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." rated "..Person:Name().." "..Found, 0)
	
	// GUI
	
	SS.Player.PlayerUpdateGUI(Person)
	
	return true
end

// Create

SS.Ratings:Create()

// Advert

SS.Adverts.Add("This server is using the Ratings plugin!")
--[[------------------------NOTE----------------------------------
	Polkm: USE THIS FILE ONLY FOR  GLOBAL VARS
		ie: Something shared omongst all players
	Polkm: Use those comment bars to organise
	Polkm: Also the shared file should never have any includes in it
	Polkm: I will try to make this file as easy to understand as posible
	Polkm: Comment bars should be this long
	------------------------------------------------------------
--------------------------NOTE----------------------------------]]

--Regular Gamemode Info----------------------------------------------------------
--Polkm: You can add more stuff here but it is going to be global jsut like the gamemode name
GM.Name 	= "StarWars RP"
GM.Author 	= "The Starwars RP Team"
GM.Email 	= "n/a"
GM.Website 	= "http://swrp.forumotion.net/index.htm?sid=19a5880a48d75552977020a9189c2628"

--Some Gamevars----------------------------------------------------------
--Polkm: These are here to make it so code nubs dont have to mess with the big boy code =)
MaxCharacters = 2

--Teams set up----------------------------------------------------------
--Polkm: Sorry MG you cant use that function to get the colors it doesn't work like that
team.SetUp(1,"Marksman",Color(25,100,40,255))	
team.SetUp(2,"Scout",Color(34,139,34,255))
team.SetUp(3,"Brawler",Color(178,34,34,255))
team.SetUp(4,"Medic",Color(25,25,112,255))

--Currencies----------------------------------------------------------
--Polkm: You could add more but its not realy nessesary this is just so its organised
Currencies = {}
Currencies["Credits"] = {Name = "Credits",Default = 500}

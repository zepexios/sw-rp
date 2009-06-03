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
team.SetUp(1,"Civilian",Color(49,79,79,255))
team.SetUp(2,"Marksman",Color(25,100,40,255))	//Marksman? Ummm...
team.SetUp(3,"Scout",Color(34,139,34,255))
team.SetUp(4,"Brawler",Color(178,34,34,255))
team.SetUp(5,"Medic",Color(25,25,112,255))

--Currencies----------------------------------------------------------
--Polkm: You could add more but its not realy nessesary this is just so its organised
Currencies = {}
Currencies["money"] = {Name = "Money",Default = 500}
Currencies["Peggets"] = {Name = "Peggets", Default = 500} 	//Currency used on Tattooine, Thanks to Coffin17 for that :)

--Weapon Classes----------------------------------------------------------
--Polkm: Feel free to add more this is all I can think of
WeaponsClasses = {}
WeaponsClasses["saber"] = {Name = "Light Sabers",Default = 0}
WeaponsClasses["pistol"] = {Name = "Laser Pistols",Default = 0}
WeaponsClasses["rifle"] = {Name = "Blaster Rilfes",Default = 0}
WeaponsClasses["hand"] = {Name = "unarmed",Default = 0}
WeaponsClasses["melee"] = {Name = "brawler",Default = 0}

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
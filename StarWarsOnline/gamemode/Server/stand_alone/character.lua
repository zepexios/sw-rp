
	/*
		Character Creation has three stages
			1. Player fills out GUI - Selections are recorded into a table
			2. The selection table is read and creates the swo table on the player
			3. The swo table is saved to the server and later sent to the SQL database
	*/
	
	/*
		TODO:
			Set other basic information to the table
				1. Inventory
				2. Quests
				3. More
	*/
	include("advbox.lua")
	
	SWO.classes = {}
	--SWO.Debug("Loading Class Plugins")
	--SWO.LoadDir("server/class_defaults/") //Load all class defaults plugins
	--Changed as its now loading recursively else where
	
	SWO.species = {}
	--SWO.Debug("Loading Species Plugins")
	--SWO.LoadDir("server/species_defaults/") //Load all class defaults plugins
	--Changed as its now loading recursively else where
	
	local function createSWOTable(ply, selections) //This function will handle stages 2 & 3 of character creation
		//STAGE 2
		ply.swo = {}
		
		ply.swo.attrib = {}
		ply.swo.attrib.health = 400
		ply.swo.attrib.str = 400 //Stregnth
		ply.swo.attrib.con = 400 //Constitution
		ply.swo.attrib.act = 400 //Action
		ply.swo.attrib.quick = 400 //Quickness
		ply.swo.attrib.stam = 400 //Stamina
		ply.swo.attrib.mind = 400
		ply.swo.attrib.focus = 400
		ply.swo.attrib.will = 400
		
		ply.swo.xp = {} //index = what type, value = how much - Must have default values
		
		ply.swo.stats = {} //Similar to attributes
			//Requires no defaults because certifications will prevent users from doing things that would call undefined stats
		
		ply.swo.skills = {} //True/false(nil) - can they use the skill - Doesn't require a default
		
		ply.swo.certs = {} //True/false(nil) - do they have the certification - Doesn't require a default
		
		ply.swo.titles = {} //True/false(nil) - do they have the title - Doesn't require a default
		
		ply.swo.species = { selections.species }
		ply.swo.model = selections.species
		
		local species = SWO.species[selections.species]
		for i, attr in pairs(species.attrib) do //Add the species modifier to the attributes to the base value
			ply.swo.attrib[i] = ply.swo.attrib[i] + attr
		end
		for i, stat in pairs(species.stats) do //Add the species modifier to the stats to the base value
			ply.swo.stats[i] = ply.swo.stats[i] + stat
		end
		for i, skill in pairs(species.skills) do //Set species skills to true
			ply.swo.skills[skill] = true
		end
		
		ply.swo.classes = { selections.class }
		
		local class = SWO.classes[selections.class]
		for i, attr in pairs(class.attrib) do //Add the class modifier to the attributes to the base value
			ply.swo.attrib[i] = ply.swo.attrib[i] + attr
		end
		
		ply.swo.boxes = {} //True/false(nil) - has the box - Doesn't require a default
		ply.swo.boxes[class.novice] = true
		
		ply.swo.inventory = {} //Will contain item data objects
		for i, item in pairs(class.equip) do //Copy all items over
			table.insert(ply.swo.inventory, table.Copy(item))
		end
		
		ply.swo.quests = {} //Will contain quest data objects
		
		//c is the prefix for 'current' - this is set after any modifications to these stats occur
		ply.swo.attrib.chealth = ply.swo.attrib.health
		ply.swo.attrib.cact = ply.swo.attrib.act
		ply.swo.attrib.cmind = ply.swo.attrib.mind
		
		ply.swo.loc = selections.loc //Set the player location

		//STAGE 3
		//TODO: Call function to save table to game server
		if ply.swo.loc.planet != SWO.planet then
			//TODO: Save to the SQL server
			ply:ConCommand("connect " .. SWO.serverIPs[ply.swo.loc.planet] .. "\n")
		end
	end

	/*
		Character Creation has three stages
			1. Player fills out GUI - Selections are recorded into a table
			2. The selection table is read and creates the swo table on the player
			3. The swo table is saved to the server and later sent to the SQL database
	*/
	
	/*
		TODO:
			Set other basic information to the table
				1. Species/model
				2. Inventory
				3. Quests
				4. Location
				5. More
	*/

	SWO.classes = {}

	function registerClassDefaults(name, tbl)
		SWO.classes[name] = tbl
	end
	include("../advbox.lua")
	SWO.LoadDir("../class_defaults/") //Load all class defaults plugins
	
	//Stage 2
	local function createSWOTable(ply, selections)
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
		
		local class = classDefaults[selections.class]
		for i, attr in pairs(class.attrib) do //Add the class modifier to the attributes to the base value
			ply.swo.attrib[i] = ply.swo.attrib[i] + attr
		end
		
		//c is the prefix for 'current' - this is set after any modifications to these stats occur
		ply.swo.attrib.chealth = ply.swo.attrib.health
		ply.swo.attrib.cact = ply.swo.attrib.act
		ply.swo.attrib.cmind = ply.swo.attrib.mind
	end
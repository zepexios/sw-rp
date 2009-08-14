
/*
	Concept Comment Block
	
	Data Storage
		1. Character data is stored on players and divided into subsets
			a. Classes
				i. Class points spent
				ii. Learned Classes Table
					1. Stores all classes in which the player has a 'novice' advancement box
					2. Contains the advancement box trees (4 per class)
						a. Contains what boxes are unlocked
						b. Contains how much XP the player has in a tree
						c. Advancement boxes
			b. Point values (factored in when players do certain tasks)
				What the value is
			c. Skills
				Whether or not the skill is unlocked
			d. Certifications
				Whether or not the player is certified to use something
		2. Data is saved in .txt files to the server and will contact the SQL server as needed
	
	Necessary Functions
		hasMastered (for class and advancement trees)
		needXP (for advancement box)
		
		Most other things that would otherwise be functions can be handled by checking if a table index exists
		
	Folder Branches (What divisions of files will be generated with this system and what the files will contain)
		1. Classes
			Classes will have functions that can be called on players to set up their data trees with the default values
				these functions will be stored in the appropriate class file
			a. Set up achievement box trees
			b. Set XP values
			c. Create point values with default values
			d. Create certifications
		2.  Skills
			Each skill will likely be it's own file, skills will cause different weapons to perform similar actions
			a. Skills can require a (type of) weapon to be equipped
			b. Skills are any action that the player would perform that wouldn't be a generic attack or conversation option
*/

if SERVER then

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
	include("../../server/advbox.lua")
	SWO.LoadDir("../../server/class_defaults/") //Load all class defaults plugins
	
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
		
		ply.swo.stats = {} //Similar to attributes
		
		ply.swo.xp = {}
		
		ply.swo.skills = {} //True/false(nil) - can they use the skill
		
		ply.swo.certs = {} //True/false(nil) - do they have the certification
		
		ply.swo.titles = {} //True/false(nil) - do they have the title
		
		local class = classDefaults[selections.class]
		for i, attr in pairs(class.attrib) do //Add the class modifier to the attributes to the base value
			ply.swo.attrib[i] = ply.swo.attrib[i] + attr
		end
		
		//c is the prefix for 'current' - this is set after any modifications to these stats occur
		ply.swo.attrib.chealth = ply.swo.attrib.health
		ply.swo.attrib.cact = ply.swo.attrib.act
		ply.swo.attrib.cmind = ply.swo.attrib.mind
	end
	
	
end

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
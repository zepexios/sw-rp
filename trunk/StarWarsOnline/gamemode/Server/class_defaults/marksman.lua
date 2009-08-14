
local marksman = {}

marksman.attrib = {}
marksman.attrib.health = 700
marksman.attrib.str = 100 //Stregnth
marksman.attrib.con = 0 //Constitution
marksman.attrib.act = 500 //Action
marksman.attrib.quick = 150 //Quickness
marksman.attrib.stam = 0 //Stamina
marksman.attrib.mind = 300
marksman.attrib.focus = 0
marksman.attrib.will = 0

marksman.boxes = {}


local gives = {} //Will be reset and reused for the creation of all advancement boxes for this class

gives.stats = {}
gives.stats.carbine_acc = 10
gives.stats.pistol_acc = 10
gives.stats.rifle_acc = 10
gives.stats.carbine_spd = 10
gives.stats.pistol_spd = 10
gives.stats.rifle_spd = 10

gives.skills = {}
table.insert(gives.skills, "overchargeshot1")
table.insert(gives.skills, "pointblankarea1")
table.insert(gives.skills, "pointblanksingle1")

gives.certs = {}
table.insert(gives.certs, "d18pistol")
table.insert(gives.certs, "dh17carbine")
table.insert(gives.certs, "dlt20rifle")

gives.titles = {}
table.insert(gives.titles, "novicemarksman")

marksman.boxes.novice_marksman = SWO.createAdvBox("Novice Marksman", {}, {}, gives)

registerClassDefaults("marksman", marksman)
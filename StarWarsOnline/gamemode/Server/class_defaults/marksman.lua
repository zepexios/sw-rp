
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
gives.stats.carbine_spd = 5
gives.stats.pistol_spd = 5
gives.stats.rifle_spd = 5

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

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.rifle_spd = 5
gives.stats.rifle_conceal = 5

gives.skills = {}
table.insert(gives.skills, "headshot1")

gives.certs = {}
table.insert(gives.certs, "dlt20arifle")
table.insert(gives.certs, "tuskanrifle")

gives.titles = {}

local XP = {}
XP["rifle_weaps"] = 1000

marksman.boxes.rifles_i = SWO.createAdvBox("Rifles I", { "novice_marksman" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.rifle_spd = 5
gives.stats.rifle_conceal = 5

gives.skills = {}
table.insert(gives.skills, "takecover")

gives.certs = {}
table.insert(gives.certs, "laserrifle")
table.insert(gives.certs, "sg82rifle")

gives.titles = {}

XP["rifle_weaps"] = 5000

marksman.boxes.rifles_ii = SWO.createAdvBox("Rifles II", { "rifles_i" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.rifle_spd = 5
gives.stats.rifle_conceal = 5

gives.skills = {}
table.insert(gives.skills, "headshot2")

gives.certs = {}
table.insert(gives.certs, "spraystick")

gives.titles = {}

XP["rifle_weaps"] = 15000

marksman.boxes.rifles_iii = SWO.createAdvBox("Rifles III", { "rifles_ii" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.rifle_spd = 5
gives.stats.rifle_conceal = 5
gives.stats.ranged_defense = 2

gives.skills = {}
table.insert(gives.skills, "mindshot1")

gives.certs = {}
table.insert(gives.certs, "e11rifle")
table.insert(gives.certs, "javaionrifle")

gives.titles = {}
table.insert(gives.titles, "apprenticesharpshooter")

XP["rifle_weaps"] = 70000

marksman.boxes.rifles_iv = SWO.createAdvBox("Rifles IV", { "rifles_iii" }, XP, gives)

gives.stats = {}
gives.stats.pistol_acc = 10
gives.stats.pistol_spd = 5

gives.skills = {}
table.insert(gives.skills, "bodyshot1")

gives.certs = {}
table.insert(gives.certs, "dl44metalpistol")
table.insert(gives.certs, "dl44pistol")

gives.titles = {}

XP = {}
XP["pistol_weaps"] = 1000

marksman.boxes.pistols_i = SWO.createAdvBox("Pistols I", { "novice_marksman" }, XP, gives)

gives.stats = {}
gives.stats.pistol_acc = 10
gives.stats.pistol_spd = 5

gives.skills = {}
table.insert(gives.skills, "diveshot")
table.insert(gives.skills, "kipupshot")
table.insert(gives.skills, "rollshot")

gives.certs = {}
table.insert(gives.certs, "dh17pistol")
table.insert(gives.certs, "scoutblaster")


XP["pistol_weaps"] = 5000

marksman.boxes.pistols_ii = SWO.createAdvBox("Pistols II", { "pistols_i" }, XP, gives)

gives.stats = {}
gives.stats.pistol_acc = 10
gives.stats.pistol_spd = 5

gives.skills = {}
table.insert(gives.skills, "bodyshot2")

gives.certs = {}
table.insert(gives.certs, "power5pistol")
table.insert(gives.certs, "strikerpistol")

XP["pistol_weaps"] = 15000

marksman.boxes.pistols_iii = SWO.createAdvBox("Pistols III", { "pistols_ii" }, XP, gives)

gives.stats = {}
gives.stats.pistol_acc = 10
gives.stats.pistol_spd = 5
gives.stats.ranged_defense = 2

gives.skills = {}
table.insert(gives.skills, "healthshot1")

gives.certs = {}
table.insert(gives.certs, "fwg5pistol")
table.insert(gives.certs, "srcombatpistol")
table.insert(gives.certs, "tanglepistol")

gives.titles = {}
table.insert(gives.titles, "Apprentice Gunfighter")

XP["pistol_weaps"] = 70000

marksman.boxes.pistols_iv = SWO.createAdvBox("Pistols IV", { "pistols_iii" }, XP, gives)

gives.stats = {}
gives.stats.carbine_acc = 10
gives.stats.carbine_spd = 5

gives.skills = {}
table.insert(gives.skills, "legshot1")

gives.certs = {}
table.insert(gives.certs, "dh17snubnosecarbine")

gives.titles = {}

XP = {}
XP["carbine_weaps"] = 1000

marksman.boxes.carbines_i = SWO.createAdvBox("Carbines I", { "novice_marksman" }, XP, gives)

gives.stats = {}
gives.stats.carbine_acc = 10
gives.stats.carbine_spd = 5

gives.skills = {}
table.insert(gives.skills, "fullautosingle")

gives.certs = {}
table.insert(gives.certs, "e11carbine")

XP["carbine_weaps"] = 5000

marksman.boxes.carbines_ii = SWO.createAdvBox("Carbines II", { "carbines_i" }, XP, gives)

gives.stats = {}
gives.stats.carbine_acc = 10
gives.stats.carbine_spd = 5

gives.skills = {}
table.insert(gives.skills, "legshot2")

gives.certs = {}
table.insert(gives.certs, "lasercarbine")

XP["carbine_weaps"] = 15000

marksman.boxes.carbines_iii = SWO.createAdvBox("Carbines III", { "carbines_ii" }, XP, gives)

gives.stats = {}
gives.stats.carbine_acc = 10
gives.stats.carbine_spd = 5
gives.stats.ranged_defense = 2

gives.skills = {}
table.insert(gives.skills, "actionshot1")

gives.certs = {}
table.insert(gives.certs, "dxr6carbine")
table.insert(gives.certs, "ee3carbine")

gives.titles = {}
table.insert(gives.titles, "Apprentice Carbine Specialist")

XP["carbine_weaps"] = 70000

marksman.boxes.carbines_iv = SWO.createAdvBox("Carbines IV", { "carbines_iii" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.pistol_acc = 10
gives.stats.carbine_acc = 10
gives.stats.ranged_defense = 2

gives.skills = {}
table.insert(gives.skills, "aim")
table.insert(gives.skills, "threatenshot")

gives.certs = {}

gives.titles = {}

XP = {}
XP["combat"] = 300

marksman.boxes.ranged_defense_i = SWO.createAdvBox("Ranged Defense I", { "novice_marksman" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.pistol_acc = 10
gives.stats.carbine_acc = 10
gives.stats.melee_defense = 2

gives.skills = {}
table.insert(gives.skills, "tumbletokneeling")
table.insert(gives.skills, "tumbletoprone")
table.insert(gives.skills, "tumbletostanding")

XP["combat"] = 2250

marksman.boxes.ranged_defense_ii = SWO.createAdvBox("Ranged Defense II", { "ranged_defense_i" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 5
gives.stats.pistol_acc = 5
gives.stats.carbine_acc = 5
gives.stats.ranged_defense = 2

gives.skills = {}
table.insert(gives.skills, "warningshot")

XP["combat"] = 6000

marksman.boxes.ranged_defense_iii = SWO.createAdvBox("Ranged Defense III", { "ranged_defense_ii" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 5
gives.stats.pistol_acc = 5
gives.stats.carbine_acc = 5
gives.stats.ranged_defense = 2
gives.stats.alertness = 10

gives.skills = {}
table.insert(gives.skills, "supressionfire1")

table.insert(gives.titles, "guardsman")

XP["combat"] = 22000

marksman.boxes.ranged_defense_iiv = SWO.createAdvBox("Ranged Defense IV", { "ranged_defense_iii" }, XP, gives)

gives.stats = {}
gives.stats.rifle_acc = 10
gives.stats.pistol_acc = 10
gives.stats.carbine_acc = 10
gives.stats.rifle_spd = 5
gives.stats.pistol_spd = 5
gives.stats.carbine_spd = 5
gives.stats.ranged_defense = 5

gives.skills = {}
table.insert(gives.skills, "overchargeshot2")

gives.titles = {}
table.insert(gives.titles, "mastermarksman")

XP = {}
XP["apprenticeship"] = 620

marksman.boxes.master_marksman = SWO.createAdvBox("Master Marksman", { "rifles_iv", "pistols_iv", "carbines_iv", "ranged_defense_iv" }, XP, gives)


registerClassDefaults("marksman", marksman)

local brawler = {}
brawler.novice = "novice_brawler"

brawler.attrib = {}
brawler.attrib.health = 700
brawler.attrib.str = 100 //Stregnth
brawler.attrib.con = 0 //Constitution
brawler.attrib.act = 500 //Action
brawler.attrib.quick = 150 //Quickness
brawler.attrib.stam = 0 //Stamina
brawler.attrib.mind = 300
brawler.attrib.focus = 0
brawler.attrib.will = 0

brawler.xp = {}
brawler.xp.unarmed_weaps = 0
brawler.xp.swords_weaps = 0
brawler.xp.polearms_weaps = 0
brawler.xp.combat = 0

//TODO: Look up actual equiptment
brawler.equip = {} //Starting equiptment
--Please dont leave half finished functions in there...
--At least create a dummy function so the code can continue!
--table.insert(marksman.equip, SWO.createItemData("shirt", 1)) //EXAMPLE


local gives = {} //Will be reset and reused for the creation of all advancement boxes for this class

gives.stats = {}
gives.stats.one-handed_center_of_being_dur = 5
gives.stats.one-handed_melee_center_of_being_eff = 10
gives.stats.one-handed_weapon_acc = 10
gives.stats.polearm_acc = 10
gives.stats.polearm_center_of_being_eff = 10
gives.stats.polearms_spd = 5
gives.stats.two-handed_melee_acc = 10
gives.stats.two-handed_melee_center_of_being = 5
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_melee_spd = 5
gives.stats.unarmed_center_of_being_dur = 5
gives.stats.unarmed_center_of_being_eff = 10
gives.stats.unarmed_dmg = 15
gives.stats.one-handed_spd = 5
gives.stats.polearm_center_of_being_dur = 5
gives.stats.taunt = 10
gives.stats.unarmed_acc = 10
gives.stats.unarmed_spd = 5

gives.skills = {}
table.insert(gives.skills, "berzerk1")
table.insert(gives.skills, "centerofbeing")
table.insert(gives.skills, "intimidate1")
table.insert(gives.skills, "one-handlunge1")
table.insert(gives.skills, "polearmlunge1")
table.insert(gives.skills, "taunt")
table.insert(gives.skills, "twohandlunge1")
table.insert(gives.skills, "unarmedlunge1")
table.insert(gives.skills, "warcry")

gives.certs = {}
table.insert(gives.certs, "daggers")

gives.titles = {}
table.insert(gives.titles, "novicebrawler")

SWO.createAdvBox("novice_brawler", "Novice Brawler", {}, {}, gives)

gives.stats = {}
gives.stats.unarmed_acc = 10
gives.stats.unarmed_spd = 5
gives.stats.unarmed_dmg = 5
gives.stats.unarmed_melee_center_of_being_dur = 2
gives.stats.unarmed_melee_center_of_being_eff = 10

gives.skills = {}
table.insert(gives.skills, "unarmedhit1")

gives.certs = {}


gives.titles = {}

XP["unarmed_weaps"] = 1000

SWO.createAdvBox("unarmed_i", "Unarmed I", { "novice_brawler" }, XP, gives)

gives.stats = {}
gives.stats.unarmed_acc = 10
gives.stats.unarmed_spd = 5
gives.stats.unarmed_dmg = 10
gives.stats.unarmed_melee_center_of_being_dur = 2
gives.stats.unarmed_melee_center_of_being_eff = 10

gives.skills = {}
table.insert(gives.skills, "unarmedstun1")

gives.certs = {}


gives.titles = {}

XP["unarmed_weaps"] = 5000
SWO.createAdvBox("unarmed_ii", "Unarmed II", { "unarmed_i" }, XP, gives)

gives.stats = {}
gives.stats.unarmed_acc = 10
gives.stats.unarmed_spd = 5
gives.stats.unarmed_dmg = 10
gives.stats.unarmed_toughness = 10
gives.stats.unarmed_melee_center_of_being_dur = 2
gives.stats.unarmed_melee_center_of_being_eff = 5

gives.skills = {}
table.insert(gives.skills, "unarmedblind1")

gives.certs = {}


gives.titles = {}


XP["unarmed_weaps"] = 15000

SWO.createAdvBox("unarmed_iii", "Unarmed III", { "unarmed_ii" }, XP, gives)

gives.stats = {}
gives.stats.unarmed_acc = 10
gives.stats.unarmed_spd = 5
gives.stats.unarmed_dmg = 10
gives.stats.unarmed_toughness = 10
gives.stats.unarmed_melee_center_of_being_dur = 2
gives.stats.unarmed_melee_center_of_being_eff = 10
gives.stats.unarmed_melee_defense = 2

gives.skills = {}
table.insert(gives.skills, "unarmedspinattack1")

gives.certs = {}


gives.titles = {}
table.insert(gives.titles, "Tera Kasi Student")

XP = {}
XP["unarmed_weaps"] = 70000

SWO.createAdvBox("unarmed_iv", "Unarmed IV", { "unarmed_iii" }, XP, gives)

gives.stats = {}
gives.stats.one-handed_center_of_being_dur = 2
gives.stats.one-handed_melee_center_of_being_eff = 10
gives.stats.one-handed_acc = 10
gives.stats.one-handed_spd = 5

gives.skills = {}
table.insert(gives.skills, "one-handhit1")

gives.certs = {}
table.insert(gives.certs, "curvedsword")
table.insert(gives.certs, "sword")
table.insert(gives.certs, "gaderiffibaton")

gives.titles = {}


XP = {}
XP["onehanded_weaps"] = 1000

SWO.createAdvBox("one-handed_i", "One-Handed I", { "novice_brawler" }, XP, gives)

gives.stats = {}
gives.stats.one-handed_center_of_being_dur = 2
gives.stats.one-handed_center_of_being_eff = 10
gives.stats.one-handed_acc = 10
gives.stats.one-handed_spd = 5

gives.skills = {}
table.insert(gives.skills, "one-handbodyhit1")


gives.certs = {}
table.insert(gives.certs, "vibroblade")



XP["onehanded_weaps"] = 5000

SWO.createAdvBox("one-handed_ii", "One-Handed II", { "one-handed_i" }, XP, gives)

gives.stats = {}
gives.stats.one-handed_center_of_being_dur = 2
gives.stats.one-handed_melee_center_of_being_eff = 10
gives.stats.one-handed_acc = 10
gives.stats.one-handed_spd = 5
gives.stats.one-handed_toughness = 10

gives.skills = {}
table.insert(gives.skills, "one-handdizzy1")

gives.certs = {}
table.insert(gives.certs, "ryykblade")


XP["pistol_weaps"] = 15000

SWO.createAdvBox("one-handed_iii", "One-Handed III", { "one-handed_ii" }, XP, gives)

gives.stats = {}
gives.stats.one-handed_center_of_being_dur = 2
gives.stats.one-handed_melee_center_of_being_eff = 10
gives.stats.one-handed_toughness = 10
gives.stats.one-handed_acc = 10
gives.stats.one-handed_spd = 5


gives.skills = {}
table.insert(gives.skills, "one-handspinattack1")

gives.certs = {}
table.insert(gives.certs, "rantoksword")


gives.titles = {}
table.insert(gives.titles, "Apprentice Swordsman")

XP["pistol_weaps"] = 70000

SWO.createAdvBox("one-handed_iv", "One-Handed IV", { "one-handed_iii" }, XP, gives)

gives.stats = {}
gives.stats.two-handed_acc = 10
gives.stats.two-handed_melee_center_of_being = 2
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_spd = 5

gives.skills = {}
table.insert(gives.skills, "two-handhit1")

gives.certs = {}
table.insert(gives.certs, "two-handedaxe")

gives.titles = {}

XP = {}
XP["two-handed_weaps"] = 1000

SWO.createAdvBox("two-handed_i", "Two-Handed I", { "novice_brawler" }, XP, gives)

gives.stats = {}
gives.stats.two-handed_acc = 10
gives.stats.two-handed_melee_center_of_being = 2
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_spd = 5

gives.skills = {}
table.insert(gives.skills, "two-handheadhit1")

gives.certs = {}
table.insert(gives.certs, "two-handedcurvedsword")

XP["two-handed_weaps"] = 5000

SWO.createAdvBox("two-handed_ii", "Two-Handed II", { "two-handed_i" }, XP, gives)

gives.stats = {}
gives.stats.two-handed_acc = 10
gives.stats.two-handed_melee_center_of_being = 2
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_spd = 5
gives.stats.two-handed_toughness = 10


gives.skills = {}
table.insert(gives.skills, "two-handsweep1")

gives.certs = {}
table.insert(gives.certs, "vibroaxe")

XP["two-handed_weaps"] = 15000

SWO.createAdvBox("two-handed_iii", "Two-Handed III", { "two-handed_ii" }, XP, gives)

gives.stats = {}
gives.stats.two-handed_acc = 10
gives.stats.two-handed_melee_center_of_being = 2
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_spd = 5
gives.stats.two-handed_toughness = 10

gives.skills = {}
table.insert(gives.skills, "two-handspinattack1")

gives.certs = {}
table.insert(gives.certs, "two-handedcleaver")


gives.titles = {}
table.insert(gives.titles, "Apprentice Heavy Swordsman")

XP["two-handed_weaps"] = 70000

SWO.createAdvBox("two-handed_iv", "Two-Handed IV", { "two-handed_iii" }, XP, gives)

gives.stats = {}
gives.stats.polearm_acc = 10
gives.stats.polearm_center_of_being_dur = 2
gives.stats.polearm_center_of_being_eff = 10
gives.stats.polearm_spd = 5

gives.skills = {}
table.insert(gives.skills, "polearmhit1")


gives.certs = {}
table.insert(gives.certs, "metalstaff")
table.insert(gives.certs, "reinforcedcombatstaff")

gives.titles = {}

XP = {}
XP["polearm_weaps"] = 1000

SWO.createAdvBox("polearm_i", "Polearm I", { "novice_brawler" }, XP, gives)

gives.stats = {}
gives.stats.polearm_acc = 10
gives.stats.polearm_center_of_being_dur = 2
gives.stats.polearm_center_of_being_eff = 10
gives.stats.polearm_spd = 5

gives.skills = {}
table.insert(gives.skills, "polearmleghit1")

XP["polearm_weaps"] = 5000

SWO.createAdvBox("polearm_ii", "Polearm II", { "polearm_i" }, XP, gives)

gives.stats = {}
gives.stats.polearm_acc = 10
gives.stats.polearm_center_of_being_dur = 2
gives.stats.polearm_center_of_being_eff = 10
gives.stats.polearm_spd = 5
gives.stats.polearm_toughness = 4

gives.skills = {}
table.insert(gives.skills, "polearmstun1")

XP["polearm_weaps"] = 15000

SWO.createAdvBox("polearm_iii", "Polearm III", { "polearm_ii" }, XP, gives)

gives.stats = {}
gives.stats.polearm_acc = 10
gives.stats.polearm_center_of_being_dur = 1
gives.stats.polearm_center_of_being_eff = 5
gives.stats.polearm_spd = 5
gives.stats.polearm_toughness = 4

gives.skills = {}
table.insert(gives.skills, "polearmspinattack1")

table.insert(gives.titles, "Apprentice Pikeman")

XP["polearm_weaps"] = 70000

SWO.createAdvBox("polearm_iv", "Polearm IV", { "Polearm_iii" }, XP, gives)

gives.stats = {}
gives.stats.berzerk = 20
gives.stats.intimidation = 20
gives.stats.melee_def = 5
gives.stats.one-handed_center_of_being_dur = 5
gives.stats.one-handed_melee_center_of_being_eff = 10
gives.stats.one-handed_toughness = 5
gives.stats.one-handed_acc = 5
gives.stats.one-handed_spd = 5
gives.stats.polearm_acc = 5
gives.stats.polearm_center_of_being_dur = 5 
gives.stats.polearm_center_of_being_eff = 10
gives.stats.polearm_spd = 5
gives.stats.polearm_toughness = 5
gives.stats.ranged_def = 5
gives.stats.taunt = 30
gives.stats.two-handed_acc = 5
gives.stats.two-handed_melee_center_of_being = 5
gives.stats.two-handed_melee_center_of_being_eff = 10
gives.stats.two-handed_spd = 5
gives.stats.two-handed_toughness = 5
gives.stats.unarmed_acc = 5
gives.stats.unarmed_center_of_being_eff = 10
gives.stats.unarmed_center_of_being = 5
gives.stats.unarmed_spd = 5
gives.stats.unarmed_toughness = 5
gives.stats.warcry = 20

gives.skills = {}
table.insert(gives.skills, "berzerk2")
table.insert(gives.skills, "intimidate2")
table.insert(gives.skills, "one-handlunge2")
table.insert(gives.skills, "polearmlunge2")
table.insert(gives.skills, "two-handlunge2")
table.insert(gives.skills, "unarmedlunge2")
table.insert(gives.skills, "warcry2")
gives.titles = {}
table.insert(gives.titles, "Master Brawler")

XP = {}
XP["apprenticeship"] = 620

SWO.createAdvBox("master_brawler", "Master Brawler", { "unarmed_iv", "one-handed_iv", "two-handed_iv", "polearms_iv" }, XP, gives)


//Set it to the table
SWO.classes["brawler"] = brawler
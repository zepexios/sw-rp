Quest = {
		UnBe.Name 					= "Unexpected Beginnings"
		UnBe.Info					= "you start in the desrt, outside Mos Eisley. You walk in and are greeted by an npc, who tells you how to play, and will give you your first quest, find someone and give them something, and return, get money, exp, and direction for the next mission."
		UnBe.Reward.XP 				= 20
		UnBe.Reward.Money 			= 10
		UnBe.Reward.Weapons			= 0
		UnBe.Reward.Items			= 0
		UnBe.Reward.Entities		= 0
		UnBe.Reward.Vehicles		= 0
		UnBe.Done					= 0
		UnBe.Instrucions			= {1 = "Go and talk to Eshingem about a package he wants you to deliver", 2 = "Take the package to <Whoever>"}
}
Quest = {
		UnBe.Name 					= "Your first vehicle"
		UnBe.Info					= "Prove to the npc that you are ready to tackle the world of SWO much faster. HINT: Parts last seen near some tuskens"
		UnBe.Reward.XP 				= 50
		UnBe.Reward.Money 			= 50
		UnBe.Reward.Weapons			= 0
		UnBe.Reward.Items			= 0
		UnBe.Reward.Entities		= 0
		UnBe.Reward.Vehicles		= "Landspeeder"
		UnBe.Done					= 0
		UnBe.Instrucions			= {1 = "Go and find parts so the speeder can be built.", 2 = "Bring the parts back to me"} -- Kill tuskens for parts = D
}
Quest = {
		UnBe.Name 					= "On Your Own"
		UnBe.Info					= "Congratulations your now ready to head out and begin your adventure on SWO!"
		UnBe.Reward.XP 				= 200
		UnBe.Reward.Money 			= 200
		UnBe.Reward.Weapons			= 0
		UnBe.Reward.Items			= 0
		UnBe.Reward.Entities		= 0
		UnBe.Reward.Vehicles		= 0
		UnBe.Done					= 0
		UnBe.Instrucions			= {1 = "Talk to the npc to finish quest."}
}
Quest = {
		UnBe.Name 					= "Moisture Farmer needs your help!"
		UnBe.Info					= "Argh, those damn Imperials are harassing me again,  they set up a bomb on my moisture collecter just a few meters south of my house.  Go take care of it."
		UnBe.Reward.XP 				= 100
		UnBe.Reward.Money 			= 50
		UnBe.Reward.Weapons			= 0
		UnBe.Reward.Items			= "Basic Health Buff"
		UnBe.Reward.Entities		= 0
		UnBe.Reward.Vehicles		= 0
		UnBe.Done					= 0
		UnBe.Instrucions			= {1 = "Go to the moisture collecter.", 2 = "Kill the imperials harassing the old Moisture Farmer.", 3 = "Report back to the Moisture Farmer."}
}
Quest = {
        UnBe.Name 					= "Jabba needs some food"
		UnBe.Info					= "Collect some ingredients for Jabbas dinner."
		UnBe.Reward.XP 				= 80
		UnBe.Reward.Money 			= 100
		UnBe.Reward.Weapons			= 0
		UnBe.Reward.Items			= 0
		UnBe.Reward.Entities		= 0
		UnBe.Reward.Vehicles		= 0
		UnBe.Done					= 0
		UnBe.Instrucions			= {1 = "Kill 5 Womp Rats", 2 = "Kill 3 Hoodlums", 3 = "Kill 1 Dragonfly."}
}

Quest.Exterminator = {
	Name 					= "Exterminator"
	Info					= "You go to the next mission, Weapon dealer? he gives you a gun, tells you to go round back and kill the rats/ antlions hanging around there... you go back, get to keep a pistol,and get exp + moneys. tells you where to get next quest"
	Reward.XP 				= 50
	Reward.Money 			= 20
	Reward.Weapons			= ""
	Reward.Entities			= ""
	Reward.Vehicles			= ""
	CompMsg					= "Well done, you killed the womp rats, and got a blaster"
	Done					= false
	Instrucions				= {1 = "Go and talk to the weapon dealer", 2 = "Go round the back, and kill the womp rats"}
	Stage					= 1
	}
function SWQuestExterminator( victim, killer, weapon )
	if(RatsKilled < 1) then
		RatsKilled = 0
	end
	if(Quest.Exterminator.Done = false) then
		if((victim:GetClass() == "npc_rat" or "npc_womprat") and (killer == LocalPlayer()) and (Quest.Exterminator.Stage == 1)) then
			if(RatsKilled > 5) then
				FinSound = Sound("content/sounds/terminated.wav")
				Quest.Exterminator.Done == true
				killer:EmitSound(FinSound)
				killer:PrintMessage( HUD_PRINTTALK, Quest.Exterminator.CompMsg )
				Quest.Exterminator.Stage == 2
				SWAddTableData( Weapons, Quest.Exterminator.Reward.Weapons )
				SWAddTableData( Items, Quest.Exterminator.Reward.Entities )
				SWAddTableData( Items, Quest.Exterminator.Reward.Money )
			end			
		else return false
		end
	else return false
	end
end
Quest.FirstVehicle = {
	Name 					= "Your first vehicle"
	Info					= "Prove to the npc that you are ready to tackle the world of SWO much faster. HINT: Parts last seen near some tuskens"
	Reward.XP 				= 50
	Reward.Money 			= 50
	Reward.Weapons			= ""
	Reward.Entities			= ""
	Reward.Vehicles			= "swo_landspeeder"
	CompMsg					= "Congrat's! You first LandSpeeder!"
	Done					= false
	Instrucions				= {1 = "Go and find parts so the speeder can be built.", 2 = "Bring the parts back to me"}
	Stage					= 1
	}
function SWQuestFirstVehicle( victim, killer, weapon
	if(PartsFound < 1) then
		PartsFound = 0
	end
	if(Quest.FirstVehicle.Done = false) then
		if((victim:GetClass() == "npc_tuscan_1" or "npc_tuscan_2" or "npc_tuscan_3") and (killer == LocalPlayer()) and (Quest.FirstVehicle.Stage == 1)) then
			if(RatsKilled > 5) then
				FinSound = Sound("content/sounds/terminated.wav")
				Quest.FirstVehicle.Done == true
				killer:EmitSound(FinSound)
				killer:PrintMessage( HUD_PRINTTALK, Quest.FirstVehicle.CompMsg )
				Quest.Exterminator.Stage == 2
				SWAddTableData( Weapons, Quest.Exterminator.Reward.Weapons )
				SWAddTableData( Items, Quest.Exterminator.Reward.Entities )
				SWAddTableData( Items, Quest.Exterminator.Reward.Money )
			end			
		else return false
		end
	else return false
	end
end































//MW Vehicles

local Category = "MW Vehicles"

local V = { 	
				// Required information
				Name = "Corvette C6", 
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Athos",
				Information = "Corvette C6",
				Model = "models/corvette/corvette.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/corvette.txt"
							}
			}

list.Set( "Vehicles", "Corvette C6", V )